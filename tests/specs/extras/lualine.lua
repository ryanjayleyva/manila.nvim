-- Lualine themes are built from the palettes, so the statusline cannot drift
-- from the editor colors.

local L = require('helpers.lualine')
local P = require('helpers.palette')
local T = require('helpers')

return function()
	for _, name in ipairs(P.themes) do
		local colors = P.colors(P.palettes[name])

		-- lualine looks a theme up by that path on the runtimepath.
		local files = vim.api.nvim_get_runtime_file(
			'lua/lualine/themes/manila-' .. name .. '.lua',
			true
		)
		T.check(
			name .. ' lualine theme is where lualine looks for it',
			#files > 0,
			'lualine will not find it'
		)

		local ok, theme = pcall(require, 'lualine.themes.manila-' .. name)
		T.check(name .. ' lualine theme loads', ok, tostring(theme))

		if ok then
			for _, mode in ipairs(L.modes) do
				local sections = theme[mode] or {}
				local derived = true
				for _, key in ipairs({ 'a', 'b', 'c' }) do
					local section = sections[key] or {}
					if not colors[section.fg] or not colors[section.bg] then
						derived = false
					end
				end
				T.check(
					('%s lualine %s sections'):format(name, mode),
					derived,
					'fg or bg is not a palette color'
				)
			end
		end
	end
end
