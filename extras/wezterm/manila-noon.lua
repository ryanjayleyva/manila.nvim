-- manila-noon for WezTerm.
-- Copy this file to your WezTerm config directory
-- ~/.config/wezterm/colors/ or .wezterm.lua
-- as manila-noon.lua, then set it in your wezterm.lua:
--   local wezterm = require 'wezterm'
--   local config = {}
--   config.color_scheme = 'manila-noon'
--   return config
-- Colors come from lua/manila/palettes/manila-noon.lua.

return {
	foreground = '#C7C0B5',
	background = '#2A221C',

	-- the cursor inverts the Normal colors, like the Cursor group
	cursor_bg = '#C7C0B5',
	cursor_fg = '#2A221C',
	cursor_border = '#C7C0B5',

	selection_bg = '#444137',
	selection_fg = '#C7C0B5',

	scrollbar_thumb = '#504741',
	split = '#504741',

	-- ansi and brights follow terminal_color_0 through terminal_color_15
	ansi = {
		'#3F3630',
		'#B58A87',
		'#949A80',
		'#B4A283',
		'#919BA5',
		'#968C9C',
		'#859C93',
		'#A8A195',
	},

	brights = {
		'#504741',
		'#B58A87',
		'#949A80',
		'#B4A283',
		'#919BA5',
		'#968C9C',
		'#859C93',
		'#C7C0B5',
	},

	compose_cursor = '#C7C0B5',

	tab_bar = {
		background = '#332B25',
		active_tab = {
			bg_color = '#2A221C',
			fg_color = '#C7C0B5',
		},
		inactive_tab = {
			bg_color = '#332B25',
			fg_color = '#A8A195',
		},
		inactive_tab_hover = {
			bg_color = '#3F3630',
			fg_color = '#C7C0B5',
		},
		new_tab = {
			bg_color = '#332B25',
			fg_color = '#A8A195',
		},
		new_tab_hover = {
			bg_color = '#3F3630',
			fg_color = '#C7C0B5',
		},
		inactive_tab_edge = '#504741',
	},
}
