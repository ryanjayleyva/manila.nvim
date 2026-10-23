-- Smoke test for manila.nvim.
-- Run with:
--   nvim --headless -l tests/smoke.lua
-- The script exits with a non zero status when a check fails.

local root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')
vim.opt.runtimepath:prepend(root)

local failures = {}
local checks = 0

local function check(name, ok, detail)
	checks = checks + 1
	if not ok then
		table.insert(failures, name .. (detail and (': ' .. detail) or ''))
	end
end

local function eq(name, got, want)
	check(
		name,
		got == want,
		('got %s, want %s'):format(tostring(got), tostring(want))
	)
end

local function hex(value)
	return value and ('#%06X'):format(value) or nil
end

local function fg(group)
	return hex(vim.api.nvim_get_hl(0, { name = group }).fg)
end

local function bg(group)
	return hex(vim.api.nvim_get_hl(0, { name = group }).bg)
end

local groups = require('manila.groups')
local manila = require('manila')

local themes = { 'day', 'night' }
local palettes = {}
for _, name in ipairs(themes) do
	palettes[name] = require(manila.themes[name])
end

-- Every palette token a group module asks for has to exist in the palette. A
-- missing token leaves the group without a color and it renders with the
-- default one instead.
local function palette_tokens()
	local tokens = {}
	local dir = root .. '/lua/manila/groups'
	for _, file in ipairs(vim.fn.readdir(dir)) do
		if file:match('%.lua$') then
			for line in io.lines(dir .. '/' .. file) do
				for token in line:gmatch('palette%.([%w_]+)') do
					-- overrides holds a table of groups, not a color.
					if token ~= 'overrides' then
						tokens[token] = true
					end
				end
			end
		end
	end
	return tokens
end

local tokens = palette_tokens()
for _, name in ipairs(themes) do
	for token in pairs(tokens) do
		check(
			('%s palette defines %s'):format(name, token),
			palettes[name][token] ~= nil,
			'a group module asks for it'
		)
	end
end

-- Standard highlight groups. A theme load clears the ones defined at runtime,
-- so collect them first.
vim.cmd.runtime('syntax/diff.vim')
local standard = {}
for _, name in ipairs(vim.fn.getcompletion('', 'highlight')) do
	standard[name] = true
end

-- Every group a theme defines has to be a group Neovim can render, and every
-- link has to point at a group that exists.
for _, name in ipairs(themes) do
	local ok, highlights = pcall(groups.highlights, palettes[name])
	if not ok then
		check(name .. ' builds highlights', false, tostring(highlights))
	else
		check(name .. ' builds highlights', next(highlights) ~= nil)

		for group, definition in pairs(highlights) do
			if not group:match('^@') then
				check(
					('%s defines %s'):format(name, group),
					standard[group] == true,
					'not a highlight group'
				)
			end

			if definition.link then
				check(
					('%s links %s to %s'):format(name, group, definition.link),
					highlights[definition.link] ~= nil
						or standard[definition.link] == true,
					'no such group'
				)
			end
		end
	end
end

-- A palette override replaces the shared definition.
local overridden = groups.highlights(vim.tbl_extend('force', palettes.day, {
	overrides = { Comment = { fg = '#123456' } },
}))
eq('override replaces a shared group', overridden.Comment.fg, '#123456')

-- Load a theme and look at the editor state it leaves behind.
for _, name in ipairs(themes) do
	local palette = palettes[name]
	manila.load(name)

	eq(name .. ' colors_name', vim.g.colors_name, 'manila-' .. name)
	eq(name .. ' background', vim.o.background, palette.background)
	eq(name .. ' termguicolors', vim.o.termguicolors, true)
	eq(name .. ' Normal fg', fg('Normal'), palette.fg)
	eq(name .. ' Normal bg', bg('Normal'), palette.bg)
	eq(name .. ' Comment fg', fg('Comment'), palette.comment)
	eq(name .. ' CursorLine bg', bg('CursorLine'), palette.cursorline)
	eq(name .. ' DiffAdd bg', bg('DiffAdd'), palette.diff_add_bg)
	eq(name .. ' DiagnosticError fg', fg('DiagnosticError'), palette.error)
	eq(name .. ' @variable fg', fg('@variable'), palette.fg)
end

-- Terminal colors follow the ANSI order.
local ansi = {
	'terminal_black',
	'red',
	'green',
	'gold',
	'blue',
	'violet',
	'teal',
	'fg_dim',
	'terminal_bright_black',
	'red',
	'green',
	'gold',
	'blue',
	'violet',
	'teal',
	'fg',
}

for _, name in ipairs(themes) do
	local palette = palettes[name]
	manila.load(name)

	for index, role in ipairs(ansi) do
		eq(
			('%s terminal_color_%d'):format(name, index - 1),
			vim.g['terminal_color_' .. (index - 1)],
			palette[role]
		)
	end
end

-- Loading clears the groups the theme does not define.
vim.api.nvim_set_hl(0, 'ManilaForeign', { fg = '#ff0000' })
manila.load('day')
check(
	'loading clears foreign groups',
	next(vim.api.nvim_get_hl(0, { name = 'ManilaForeign' })) == nil,
	'the group survived'
)

-- Switching back restores the first theme.
manila.load('night')
manila.load('day')
eq('day Normal bg after switching back', bg('Normal'), palettes.day.bg)
eq('day Comment fg after switching back', fg('Comment'), palettes.day.comment)
eq('day colors_name after switching back', vim.g.colors_name, 'manila-day')

-- The colorscheme entry points keep working.
vim.cmd.colorscheme('manila-night')
eq('colorscheme manila-night', vim.g.colors_name, 'manila-night')
eq('colorscheme manila-night Normal bg', bg('Normal'), palettes.night.bg)
vim.cmd.colorscheme('manila-day')
eq('colorscheme manila-day', vim.g.colors_name, 'manila-day')
eq('colorscheme manila-day Normal bg', bg('Normal'), palettes.day.bg)

-- Lualine themes are built from the palettes, so the statusline cannot drift
-- from the editor colors.
local lualine_modes = {
	'normal',
	'insert',
	'visual',
	'replace',
	'command',
	'terminal',
	'inactive',
}

for _, name in ipairs(themes) do
	local palette = palettes[name]

	local colors = {}
	for _, value in pairs(palette) do
		if type(value) == 'string' and value:match('^#%x%x%x%x%x%x$') then
			colors[value] = true
		end
	end

	-- lualine looks a theme up by that path on the runtimepath.
	local files = vim.api.nvim_get_runtime_file(
		'lua/lualine/themes/manila-' .. name .. '.lua',
		true
	)
	check(
		name .. ' lualine theme is where lualine looks for it',
		#files > 0,
		'lualine will not find it'
	)

	local ok, theme = pcall(require, 'lualine.themes.manila-' .. name)
	check(name .. ' lualine theme loads', ok, tostring(theme))

	if ok then
		for _, mode in ipairs(lualine_modes) do
			local sections = theme[mode] or {}
			local derived = true
			for _, key in ipairs({ 'a', 'b', 'c' }) do
				local section = sections[key] or {}
				if not colors[section.fg] or not colors[section.bg] then
					derived = false
				end
			end
			check(
				('%s lualine %s sections'):format(name, mode),
				derived,
				'fg or bg is not a palette color'
			)
		end
	end
end

-- Unknown themes are rejected and leave the loaded theme alone.
local accepted = pcall(manila.load, 'dusk')
check(
	'unknown theme is rejected',
	not accepted,
	'load() accepted an unknown theme'
)
eq('failed load keeps the theme', vim.g.colors_name, 'manila-day')

-- Contrast against the background.
local function luminance(color)
	local r, g, b = color:match('#(%x%x)(%x%x)(%x%x)')
	local function channel(value)
		value = value / 255
		if value <= 0.03928 then
			return value / 12.92
		end
		return ((value + 0.055) / 1.055) ^ 2.4
	end
	return 0.2126 * channel(tonumber(r, 16))
		+ 0.7152 * channel(tonumber(g, 16))
		+ 0.0722 * channel(tonumber(b, 16))
end

local function contrast(first, second)
	local high, low = luminance(first), luminance(second)
	if high < low then
		high, low = low, high
	end
	return (high + 0.05) / (low + 0.05)
end

for _, name in ipairs(themes) do
	local palette = palettes[name]

	local text = contrast(palette.fg, palette.bg)
	check(
		('%s text contrast'):format(name),
		text >= 7,
		('%.2f:1, needs 7:1'):format(text)
	)

	local comment = contrast(palette.comment, palette.bg)
	check(
		('%s comment contrast'):format(name),
		comment >= 4.5,
		('%.2f:1, needs 4.5:1'):format(comment)
	)

	local theme = require('lualine.themes.manila-' .. name)
	for _, mode in ipairs(lualine_modes) do
		for _, key in ipairs({ 'a', 'b', 'c' }) do
			local section = theme[mode][key]
			local ratio = contrast(section.fg, section.bg)
			check(
				('%s lualine %s%s contrast'):format(name, mode, key),
				ratio >= 4.5,
				('%.2f:1, needs 4.5:1'):format(ratio)
			)
		end
	end
end

if #failures > 0 then
	io.stderr:write(('%d of %d checks failed:\n'):format(#failures, checks))
	for _, failure in ipairs(failures) do
		io.stderr:write('  - ' .. failure .. '\n')
	end
	os.exit(1)
end

io.stdout:write(('%d checks passed\n'):format(checks))
