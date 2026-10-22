local M = {}

M = {
	-- surfaces
	bg = '#F0E7D8',
	surface = '#EAE0D1',
	surface_hi = '#DDD2C0',
	cursorline = '#EBE1D1',
	selection = '#C9D2D8',
	search = '#E6D3A3',

	-- neutrals
	fg = '#4A433C',
	fg_dim = '#62584D',
	comment = '#6C6153',
	line_nr = '#82766A',
	border = '#BFB29D',

	-- accents
	red = '#9F4D4A',
	blue = '#4A6482',
	gold = '#7F5E28',
	green = '#536C57',
	teal = '#476C65',
	clay = '#8A5C45',
	violet = '#776E88',

	-- diagnostics
	error = '#9F4D4A',
	warn = '#7F5E28',
	info = '#4A6482',
	hint = '#476C65',

	-- diff
	diff_add = '#536C57',
	diff_change = '#4A6482',
	diff_delete = '#9F4D4A',
	diff_add_bg = '#DDE2CE',
	diff_change_bg = '#D9DEDC',
	diff_delete_bg = '#EBD3C9',
}

M.background = 'light'
M.terminal_black = M.fg
M.terminal_bright_black = M.line_nr

return M
