-- Palette, highlight and loading behavior.

local P = require('helpers.palette')
local T = require('helpers')
local groups = require('manila.groups')
local manila = require('manila')

local function hex(value)
	return value and ('#%06X'):format(value) or nil
end

local function fg(group)
	return hex(vim.api.nvim_get_hl(0, { name = group }).fg)
end

local function bg(group)
	return hex(vim.api.nvim_get_hl(0, { name = group }).bg)
end

-- Every palette token a group module asks for has to exist in the palette. A
-- missing token leaves the group without a color and it renders with the
-- default one instead.
local function palette_tokens()
	local tokens = {}
	local dir = T.root .. '/lua/manila/groups'
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

return function()
	local palettes = P.palettes

	local tokens = palette_tokens()
	for _, name in ipairs(P.themes) do
		for token in pairs(tokens) do
			T.check(
				('%s palette defines %s'):format(name, token),
				palettes[name][token] ~= nil,
				'a group module asks for it'
			)
		end
	end

	-- Each theme is tuned for one background mode.
	local modes = { day = 'light', night = 'dark', noon = 'dark' }
	for _, name in ipairs(P.themes) do
		T.eq(name .. ' background mode', palettes[name].background, modes[name])
	end

	-- Standard highlight groups. A theme load clears the ones defined at
	-- runtime, so collect them first.
	vim.cmd.runtime('syntax/diff.vim')
	local standard = {}
	for _, name in ipairs(vim.fn.getcompletion('', 'highlight')) do
		standard[name] = true
	end

	-- Every group a theme defines has to be a group Neovim can render, and
	-- every link has to point at a group that exists.
	for _, name in ipairs(P.themes) do
		local ok, highlights = pcall(groups.highlights, palettes[name])
		if not ok then
			T.check(name .. ' builds highlights', false, tostring(highlights))
		else
			T.check(name .. ' builds highlights', next(highlights) ~= nil)

			for group, definition in pairs(highlights) do
				if not group:match('^@') then
					T.check(
						('%s defines %s'):format(name, group),
						standard[group] == true,
						'not a highlight group'
					)
				end

				if definition.link then
					T.check(
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
	T.eq('override replaces a shared group', overridden.Comment.fg, '#123456')

	-- Load a theme and look at the editor state it leaves behind.
	for _, name in ipairs(P.themes) do
		local palette = palettes[name]
		manila.load(name)

		T.eq(name .. ' colors_name', vim.g.colors_name, 'manila-' .. name)
		T.eq(name .. ' background', vim.o.background, palette.background)
		T.eq(name .. ' termguicolors', vim.o.termguicolors, true)
		T.eq(name .. ' Normal fg', fg('Normal'), palette.fg)
		T.eq(name .. ' Normal bg', bg('Normal'), palette.bg)
		T.eq(name .. ' Comment fg', fg('Comment'), palette.comment)
		T.eq(name .. ' CursorLine bg', bg('CursorLine'), palette.cursorline)
		T.eq(name .. ' DiffAdd bg', bg('DiffAdd'), palette.diff_add_bg)
		T.eq(name .. ' DiagnosticError fg', fg('DiagnosticError'), palette.error)
		T.eq(name .. ' @variable fg', fg('@variable'), palette.fg)
	end

	for _, name in ipairs(P.themes) do
		local palette = palettes[name]
		manila.load(name)

		for index, role in ipairs(ansi) do
			T.eq(
				('%s terminal_color_%d'):format(name, index - 1),
				vim.g['terminal_color_' .. (index - 1)],
				palette[role]
			)
		end
	end

	-- Loading clears the groups the theme does not define.
	vim.api.nvim_set_hl(0, 'ManilaForeign', { fg = '#ff0000' })
	manila.load('day')
	T.check(
		'loading clears foreign groups',
		next(vim.api.nvim_get_hl(0, { name = 'ManilaForeign' })) == nil,
		'the group survived'
	)

	-- Switching back restores the first theme.
	manila.load('night')
	manila.load('day')
	T.eq('day Normal bg after switching back', bg('Normal'), palettes.day.bg)
	T.eq(
		'day Comment fg after switching back',
		fg('Comment'),
		palettes.day.comment
	)
	T.eq('day colors_name after switching back', vim.g.colors_name, 'manila-day')

	-- Noon clears what the other themes left and is restored the same way.
	vim.api.nvim_set_hl(0, 'ManilaForeign', { fg = '#ff0000' })
	manila.load('noon')
	T.check(
		'loading noon clears foreign groups',
		next(vim.api.nvim_get_hl(0, { name = 'ManilaForeign' })) == nil,
		'the group survived'
	)
	manila.load('night')
	manila.load('noon')
	T.eq('noon Normal bg after switching back', bg('Normal'), palettes.noon.bg)
	T.eq(
		'noon Comment fg after switching back',
		fg('Comment'),
		palettes.noon.comment
	)
	T.eq(
		'noon colors_name after switching back',
		vim.g.colors_name,
		'manila-noon'
	)

	-- The colorscheme entry points keep working.
	vim.cmd.colorscheme('manila-night')
	T.eq('colorscheme manila-night', vim.g.colors_name, 'manila-night')
	T.eq('colorscheme manila-night Normal bg', bg('Normal'), palettes.night.bg)
	vim.cmd.colorscheme('manila-noon')
	T.eq('colorscheme manila-noon', vim.g.colors_name, 'manila-noon')
	T.eq('colorscheme manila-noon Normal bg', bg('Normal'), palettes.noon.bg)
	vim.cmd.colorscheme('manila-day')
	T.eq('colorscheme manila-day', vim.g.colors_name, 'manila-day')
	T.eq('colorscheme manila-day Normal bg', bg('Normal'), palettes.day.bg)

	-- Unknown themes are rejected and leave the loaded theme alone.
	local accepted = pcall(manila.load, 'dusk')
	T.check(
		'unknown theme is rejected',
		not accepted,
		'load() accepted an unknown theme'
	)
	T.eq('failed load keeps the theme', vim.g.colors_name, 'manila-day')
end
