-- Vim syntax groups.

local M = {}

---@param palette manila.Palette
---@return table<string, vim.api.keyset.highlight>
function M.highlights(palette)
	return {
		Comment = { fg = palette.comment, italic = true },
		Constant = { fg = palette.gold },
		String = { fg = palette.green },
		Character = { link = 'String' },
		Number = { link = 'Constant' },
		Boolean = { link = 'Constant' },
		Float = { link = 'Constant' },
		Identifier = { fg = palette.fg },
		Function = { fg = palette.blue },
		Statement = { fg = palette.red },
		Conditional = { link = 'Statement' },
		Repeat = { link = 'Statement' },
		Label = { link = 'Statement' },
		Operator = { fg = palette.fg_dim },
		Keyword = { fg = palette.red },
		Exception = { link = 'Statement' },
		PreProc = { fg = palette.clay },
		Include = { link = 'PreProc' },
		Define = { link = 'PreProc' },
		Macro = { link = 'PreProc' },
		PreCondit = { link = 'PreProc' },
		Type = { fg = palette.teal },
		StorageClass = { link = 'Statement' },
		Structure = { link = 'Type' },
		Typedef = { link = 'Type' },
		Special = { fg = palette.clay },
		SpecialChar = { link = 'Special' },
		Tag = { fg = palette.violet },
		Delimiter = { fg = palette.fg_dim },
		SpecialComment = { fg = palette.comment, bold = true, italic = true },
		Debug = { link = 'Special' },
		Underlined = { underline = true },
		Ignore = { fg = palette.comment },
		Error = { fg = palette.error },
		Todo = { fg = palette.gold, bold = true },
		Added = { fg = palette.diff_add },
		Changed = { fg = palette.diff_change },
		Removed = { fg = palette.diff_delete },
	}
end

return M
