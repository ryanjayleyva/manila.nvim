-- manila-night for WezTerm.
-- Copy this file to your WezTerm config directory
-- ~/.config/wezterm/colors/ or .wezterm.lua
-- as manila-night.lua, then set it in your wezterm.lua:
--   local wezterm = require 'wezterm'
--   local config = {}
--   config.color_scheme = 'manila-night'
--   return config
-- Colors come from lua/manila/palettes/manila-night.lua.

return {
	foreground = '#D9D0C3',
	background = '#252729',

	-- the cursor inverts the Normal colors, like the Cursor group
	cursor_bg = '#D9D0C3',
	cursor_fg = '#252729',
	cursor_border = '#D9D0C3',

	selection_bg = '#3D4A58',
	selection_fg = '#D9D0C3',

	scrollbar_thumb = '#4A4A47',
	split = '#4A4A47',

	-- ansi and brights follow terminal_color_0 through terminal_color_15
	ansi = {
		'#3A3B3A',
		'#D1847D',
		'#8DA58D',
		'#D4B36F',
		'#91A9C5',
		'#8F879B',
		'#78A39A',
		'#BEB4A5',
	},

	brights = {
		'#4A4A47',
		'#D1847D',
		'#8DA58D',
		'#D4B36F',
		'#91A9C5',
		'#8F879B',
		'#78A39A',
		'#D9D0C3',
	},

	compose_cursor = '#D9D0C3',

	tab_bar = {
		background = '#2F3030',
		active_tab = {
			bg_color = '#252729',
			fg_color = '#D9D0C3',
		},
		inactive_tab = {
			bg_color = '#2F3030',
			fg_color = '#BEB4A5',
		},
		inactive_tab_hover = {
			bg_color = '#3A3B3A',
			fg_color = '#D9D0C3',
		},
		new_tab = {
			bg_color = '#2F3030',
			fg_color = '#BEB4A5',
		},
		new_tab_hover = {
			bg_color = '#3A3B3A',
			fg_color = '#D9D0C3',
		},
		inactive_tab_edge = '#4A4A47',
	},
}
