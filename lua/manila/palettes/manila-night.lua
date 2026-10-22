local M = {}

M = {
	-- surfaces
	bg = '#252729',
	surface = '#2F3030',
	surface_hi = '#3A3B3A',
	cursorline = '#2B2D2E',
	selection = '#3D4A58',
	search = '#5A4D2E',

	-- neutrals
	fg = '#D9D0C3',
	fg_dim = '#BEB4A5',
	comment = '#A89F91',
	line_nr = '#8C8579',
	border = '#4A4A47',

	-- accents
	red = '#D1847D',
	blue = '#91A9C5',
	gold = '#D4B36F',
	green = '#8DA58D',
	teal = '#78A39A',
	clay = '#B8876D',
	violet = '#8F879B',

	-- diagnostics
	error = '#D1847D',
	warn = '#D4B36F',
	info = '#91A9C5',
	hint = '#78A39A',

	-- diff
	diff_add = '#8DA58D',
	diff_change = '#91A9C5',
	diff_delete = '#D1847D',
	diff_add_bg = '#2F3A31',
	diff_change_bg = '#2F3944',
	diff_delete_bg = '#41302F',
}

M.background = 'dark'
M.terminal_black = M.surface_hi
M.terminal_bright_black = M.border

return M
