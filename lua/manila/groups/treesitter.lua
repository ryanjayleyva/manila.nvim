-- Tree-sitter captures. Most fall back to the Vim groups.
-- List only semantic differences.

local M = {}

---@param palette manila.Palette
---@return table<string, vim.api.keyset.highlight>
function M.highlights(palette)
	return {
		['@variable'] = { fg = palette.fg },
		['@variable.builtin'] = { fg = palette.red },
		['@variable.parameter'] = { fg = palette.fg },
		['@variable.member'] = { fg = palette.fg },
		['@property'] = { fg = palette.fg },
		['@module'] = { fg = palette.fg },
		['@constant.builtin'] = { fg = palette.gold },
		['@type.builtin'] = { fg = palette.teal },
		['@constructor'] = { fg = palette.teal },
		['@function.builtin'] = { fg = palette.blue },
		['@function.call'] = { fg = palette.blue },
		['@keyword.function'] = { fg = palette.red },
		['@keyword.return'] = { fg = palette.red },
		['@punctuation.delimiter'] = { fg = palette.fg_dim },
		['@punctuation.bracket'] = { fg = palette.fg_dim },
		['@punctuation.special'] = { fg = palette.clay },
		['@string.escape'] = { fg = palette.clay },
		['@string.regexp'] = { fg = palette.clay },
		['@string.special.url'] = { fg = palette.blue, underline = true },
		['@attribute'] = { fg = palette.violet },
		['@tag'] = { fg = palette.red },
		['@tag.attribute'] = { fg = palette.violet },
		['@tag.delimiter'] = { fg = palette.fg_dim },
		['@comment.todo'] = { link = 'Todo' },
		['@comment.error'] = { fg = palette.error, bold = true },
		['@comment.warning'] = { fg = palette.warn, bold = true },
		['@comment.note'] = { fg = palette.info, bold = true },
		['@markup.heading'] = { fg = palette.blue, bold = true },
		['@markup.strong'] = { bold = true },
		['@markup.italic'] = { italic = true },
		['@markup.strikethrough'] = { strikethrough = true },
		['@markup.underline'] = { underline = true },
		['@markup.link'] = { fg = palette.blue },
		['@markup.link.url'] = { fg = palette.blue, underline = true },
		['@markup.raw'] = { fg = palette.green },
		['@markup.list'] = { fg = palette.gold },
		['@diff.plus'] = { fg = palette.diff_add },
		['@diff.minus'] = { fg = palette.diff_delete },
		['@diff.delta'] = { fg = palette.diff_change },
	}
end

return M
