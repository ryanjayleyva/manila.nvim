-- Editor UI highlights.

local M = {}

---@param palette manila.Palette
---@return table<string, vim.api.keyset.highlight>
function M.highlights(palette)
	return {
		Normal = { fg = palette.fg, bg = palette.bg },
		NormalNC = { fg = palette.fg, bg = palette.bg },
		NormalFloat = { fg = palette.fg, bg = palette.surface },
		FloatBorder = { fg = palette.border, bg = palette.surface },
		FloatTitle = { fg = palette.blue, bg = palette.surface, bold = true },
		FloatFooter = { fg = palette.fg_dim, bg = palette.surface },

		Cursor = { fg = palette.bg, bg = palette.fg },
		lCursor = { link = 'Cursor' },
		CursorIM = { link = 'Cursor' },
		TermCursor = { link = 'Cursor' },
		CursorLine = { bg = palette.cursorline },
		CursorColumn = { link = 'CursorLine' },
		ColorColumn = { bg = palette.surface },
		LineNr = { fg = palette.line_nr },
		LineNrAbove = { link = 'LineNr' },
		LineNrBelow = { link = 'LineNr' },
		CursorLineNr = { fg = palette.gold, bold = true },
		SignColumn = { fg = palette.line_nr, bg = palette.bg },
		FoldColumn = { fg = palette.line_nr, bg = palette.bg },
		Folded = { fg = palette.fg_dim, bg = palette.surface },

		Visual = { bg = palette.selection },
		VisualNOS = { link = 'Visual' },
		Search = { fg = palette.fg, bg = palette.search },
		CurSearch = {
			fg = palette.fg,
			bg = palette.search,
			bold = true,
			underline = true,
		},
		IncSearch = { link = 'CurSearch' },
		Substitute = { link = 'CurSearch' },
		MatchParen = { fg = palette.gold, bold = true, underline = true },

		Pmenu = { fg = palette.fg, bg = palette.surface },
		PmenuSel = { fg = palette.fg, bg = palette.selection, bold = true },
		PmenuKind = { fg = palette.teal, bg = palette.surface },
		PmenuKindSel = { fg = palette.teal, bg = palette.selection },
		PmenuExtra = { fg = palette.fg_dim, bg = palette.surface },
		PmenuExtraSel = { fg = palette.fg_dim, bg = palette.selection },
		PmenuSbar = { bg = palette.surface_hi },
		PmenuThumb = { bg = palette.border },
		PmenuMatch = { fg = palette.gold, bg = palette.surface, bold = true },
		PmenuMatchSel = { fg = palette.gold, bg = palette.selection, bold = true },
		WildMenu = { link = 'PmenuSel' },

		WinSeparator = { fg = palette.border },
		VertSplit = { link = 'WinSeparator' },
		StatusLine = { fg = palette.fg, bg = palette.surface },
		StatusLineNC = { fg = palette.fg_dim, bg = palette.surface },
		TabLine = { fg = palette.fg_dim, bg = palette.surface },
		TabLineSel = { fg = palette.fg, bg = palette.bg, bold = true },
		TabLineFill = { bg = palette.surface },
		WinBar = { fg = palette.fg, bg = palette.bg, bold = true },
		WinBarNC = { fg = palette.fg_dim, bg = palette.bg },

		Title = { fg = palette.blue, bold = true },
		Directory = { fg = palette.blue },
		NonText = { fg = palette.border },
		EndOfBuffer = { fg = palette.bg },
		Whitespace = { fg = palette.border },
		SpecialKey = { fg = palette.border },
		Conceal = { fg = palette.fg_dim },
		QuickFixLine = { bg = palette.selection },
		Question = { fg = palette.green },
		MoreMsg = { fg = palette.green },
		ModeMsg = { fg = palette.fg_dim },
		ErrorMsg = { fg = palette.error, bold = true },
		WarningMsg = { fg = palette.warn },

		SpellBad = { sp = palette.error, undercurl = true },
		SpellCap = { sp = palette.warn, undercurl = true },
		SpellLocal = { sp = palette.info, undercurl = true },
		SpellRare = { sp = palette.hint, undercurl = true },
	}
end

return M
