-- Lualine theme built from a palette.
-- lualine loads these through lua/lualine/themes/manila-day.lua and
-- lua/lualine/themes/manila-night.lua. With theme = 'auto' it picks the file
-- named after the active colorscheme, so the statusline follows the theme.

local M = {}

---Mode accents. Each block uses the background as its foreground, the same
---pairing as the Cursor group.
local accents = {
	normal = 'blue',
	insert = 'green',
	visual = 'gold',
	replace = 'red',
	command = 'clay',
	terminal = 'teal',
}

---@param palette manila.Palette
---@return table lualine theme
function M.theme(palette)
	local theme = {
		inactive = {
			a = { fg = palette.fg_dim, bg = palette.surface, gui = 'bold' },
			b = { fg = palette.comment, bg = palette.surface },
			c = { fg = palette.comment, bg = palette.surface },
		},
	}

	for mode, accent in pairs(accents) do
		theme[mode] = {
			a = { fg = palette.bg, bg = palette[accent], gui = 'bold' },
			b = { fg = palette.fg, bg = palette.surface_hi },
			c = { fg = palette.fg_dim, bg = palette.surface },
		}
	end

	return theme
end

return M
