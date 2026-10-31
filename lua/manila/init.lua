-- manila.nvim loader.
--
-- The colorscheme files in colors/ are thin wrappers around M.load:
--
--   colors/manila-day.lua   -> require('manila').load('day')
--   colors/manila-night.lua -> require('manila').load('night')
--   colors/manila-noon.lua  -> require('manila').load('noon')
--
-- Every theme owns its palette in lua/manila/palettes/. The highlight groups
-- in lua/manila/groups/ are shared between the themes and only ever read
-- from a palette, so a theme never depends on another theme.

---A theme palette: semantic color tokens plus the optional per theme
---overrides of highlight groups.
---@class manila.Palette
---@field background 'light'|'dark' Background mode the palette is tuned for.
---@field overrides? table<string, vim.api.keyset.highlight> Highlight groups that differ per theme.
---@field [string] string|table<string, vim.api.keyset.highlight> Semantic color tokens.

local M = {}

---Themes shipped with manila and the palette module each one uses.
---@type table<string, string>
M.themes = {
	day = 'manila.palettes.manila-day',
	night = 'manila.palettes.manila-night',
	noon = 'manila.palettes.manila-noon',
}

---Load a theme. Safe to call repeatedly, including when switching themes.
---@param theme string theme name, for example "day", "night" or "noon"
function M.load(theme)
	local palette_module = M.themes[theme]
	if not palette_module then
		error(('manila: unknown theme %q'):format(tostring(theme)))
	end

	local palette = require(palette_module)
	local groups = require('manila.groups')

	vim.o.termguicolors = true
	-- Set the background first. Changing it resets the default highlights,
	-- so it has to happen before the theme groups are applied.
	vim.o.background = palette.background

	-- Drop the highlights of the previous theme so nothing stale is left.
	vim.cmd('highlight clear')
	if vim.fn.exists('syntax_on') == 1 then
		vim.cmd('syntax reset')
	end

	vim.g.colors_name = 'manila-' .. theme

	for group, definition in pairs(groups.highlights(palette)) do
		vim.api.nvim_set_hl(0, group, definition)
	end
	for index, color in ipairs(groups.terminal_colors(palette)) do
		vim.g['terminal_color_' .. (index - 1)] = color
	end
end

return M
