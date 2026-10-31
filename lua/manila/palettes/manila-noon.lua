local M = {}

M = {
	-- surfaces
	bg = '#2A221C',
	surface = '#332B25',
	surface_hi = '#3F3630',
	cursorline = '#2F2721',
	selection = '#444137',
	search = '#58462D',

	-- neutrals
	fg = '#C7C0B5',
	fg_dim = '#A8A195',
	comment = '#9A9286',
	line_nr = '#787167',
	border = '#504741',

	-- accents
	red = '#B58A87',
	blue = '#919BA5',
	gold = '#B4A283',
	green = '#949A80',
	teal = '#859C93',
	clay = '#AB8C72',
	violet = '#968C9C',

	-- diagnostics
	error = '#B58A87',
	warn = '#B4A283',
	info = '#919BA5',
	hint = '#859C93',

	-- diff
	diff_add = '#949A80',
	diff_change = '#919BA5',
	diff_delete = '#B58A87',
	diff_add_bg = '#2E3025',
	diff_change_bg = '#2B312E',
	diff_delete_bg = '#3A2C29',
}

M.background = 'dark'
M.terminal_black = M.surface_hi
M.terminal_bright_black = M.border

return M
