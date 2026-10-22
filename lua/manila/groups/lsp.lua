-- LSP highlights, semantic tokens, and diagnostics.

local M = {}

---@param palette manila.Palette
---@return table<string, vim.api.keyset.highlight>
function M.highlights(palette)
	return {
		DiagnosticError = { fg = palette.error },
		DiagnosticWarn = { fg = palette.warn },
		DiagnosticInfo = { fg = palette.info },
		DiagnosticHint = { fg = palette.hint },
		DiagnosticOk = { fg = palette.green },
		DiagnosticVirtualTextError = { fg = palette.error },
		DiagnosticVirtualTextWarn = { fg = palette.warn },
		DiagnosticVirtualTextInfo = { fg = palette.info },
		DiagnosticVirtualTextHint = { fg = palette.hint },
		DiagnosticUnderlineError = { sp = palette.error, undercurl = true },
		DiagnosticUnderlineWarn = { sp = palette.warn, undercurl = true },
		DiagnosticUnderlineInfo = { sp = palette.info, undercurl = true },
		DiagnosticUnderlineHint = { sp = palette.hint, underdotted = true },
		DiagnosticFloatingError = { link = 'DiagnosticError' },
		DiagnosticFloatingWarn = { link = 'DiagnosticWarn' },
		DiagnosticFloatingInfo = { link = 'DiagnosticInfo' },
		DiagnosticFloatingHint = { link = 'DiagnosticHint' },
		DiagnosticSignError = { link = 'DiagnosticError' },
		DiagnosticSignWarn = { link = 'DiagnosticWarn' },
		DiagnosticSignInfo = { link = 'DiagnosticInfo' },
		DiagnosticSignHint = { link = 'DiagnosticHint' },
		DiagnosticDeprecated = { sp = palette.fg_dim, strikethrough = true },
		DiagnosticUnnecessary = { fg = palette.comment },

		LspReferenceText = { bg = palette.surface_hi },
		LspReferenceRead = { bg = palette.surface_hi },
		LspReferenceWrite = { bg = palette.surface_hi, underline = true },
		LspInlayHint = { fg = palette.comment, bg = palette.surface },
		LspCodeLens = { fg = palette.comment },
		LspSignatureActiveParameter = { fg = palette.gold, bold = true },

		-- Let the @comment styling apply instead of LSP's semantic token default.
		['@lsp.type.comment'] = {},
		['@lsp.type.namespace'] = { link = '@module' },
		['@lsp.type.parameter'] = { link = '@variable.parameter' },
		['@lsp.type.property'] = { link = '@property' },
		['@lsp.typemod.variable.defaultLibrary'] = { link = '@variable.builtin' },
		['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' },
	}
end

return M
