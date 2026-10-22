-- Aggregate the highlight definitions of every group module.
-- Each module exposes the same interface:
--   M.highlights(palette) -> table<string, vim.api.keyset.highlight>
-- A group belongs to exactly one module. The duplicate check below keeps it
-- that way. Theme specific definitions live in the palette and are applied
-- last, so a theme can override a shared group without touching the shared
-- modules.

local M = {}

---Modules that contribute highlight groups, in the order they are merged.
local modules = { 'editor', 'syntax', 'treesitter', 'lsp', 'diff' }

---Build the highlight table of a palette.
---@param palette manila.Palette
---@return table<string, vim.api.keyset.highlight>
function M.highlights(palette)
	local highlights = {}

	for _, module in ipairs(modules) do
		local definitions = require('manila.groups.' .. module).highlights(palette)
		for group, definition in pairs(definitions) do
			assert(
				highlights[group] == nil,
				('manila: %s defined twice (again in %s)'):format(group, module)
			)
			highlights[group] = definition
		end
	end

	for group, definition in pairs(palette.overrides or {}) do
		highlights[group] = definition
	end

	return highlights
end

---Terminal ANSI colors (0-15) derived from the palette.
---@param palette manila.Palette
---@return string[]
function M.terminal_colors(palette)
	return {
		palette.terminal_black,
		palette.red,
		palette.green,
		palette.gold,
		palette.blue,
		palette.violet,
		palette.teal,
		palette.fg_dim,
		palette.terminal_bright_black,
		palette.red,
		palette.green,
		palette.gold,
		palette.blue,
		palette.violet,
		palette.teal,
		palette.fg,
	}
end

return M
