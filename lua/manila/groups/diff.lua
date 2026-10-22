-- Diff and git highlights.

local M = {}

---@param palette manila.Palette
---@return table<string, vim.api.keyset.highlight>
function M.highlights(palette)
	return {
		DiffAdd = { bg = palette.diff_add_bg },
		DiffChange = { bg = palette.diff_change_bg },
		DiffDelete = { fg = palette.diff_delete, bg = palette.diff_delete_bg },
		DiffText = { bg = palette.selection, bold = true },
		diffAdded = { fg = palette.diff_add },
		diffRemoved = { fg = palette.diff_delete },
		diffChanged = { fg = palette.diff_change },
		diffFile = { fg = palette.blue },
		diffLine = { fg = palette.comment },
	}
end

return M
