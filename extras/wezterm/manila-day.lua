-- manila-day for WezTerm.
-- Copy this file to your WezTerm config directory
-- ~/.config/wezterm/colors/ or .wezterm.lua
-- as manila-day.lua, then set it in your wezterm.lua:
--   local wezterm = require 'wezterm'
--   local config = {}
--   config.color_scheme = 'manila-day'
--   return config
-- Colors come from lua/manila/palettes/manila-day.lua.

return {
	foreground = '#4A433C',
	background = '#F0E7D8',

	-- the cursor inverts the Normal colors, like the Cursor group
	cursor_bg = '#4A433C',
	cursor_fg = '#F0E7D8',
	cursor_border = '#4A433C',

	selection_bg = '#C9D2D8',
	selection_fg = '#4A433C',

	scrollbar_thumb = '#BFB29D',
	split = '#BFB29D',

	-- ansi and brights follow terminal_color_0 through terminal_color_15
	ansi = {
		'#4A433C',
		'#9F4D4A',
		'#536C57',
		'#7F5E28',
		'#4A6482',
		'#776E88',
		'#476C65',
		'#62584D',
	},

	brights = {
		'#82766A',
		'#9F4D4A',
		'#536C57',
		'#7F5E28',
		'#4A6482',
		'#776E88',
		'#476C65',
		'#4A433C',
	},

	compose_cursor = '#4A433C',

	tab_bar = {
		background = '#EAE0D1',
		active_tab = {
			bg_color = '#F0E7D8',
			fg_color = '#4A433C',
		},
		inactive_tab = {
			bg_color = '#EAE0D1',
			fg_color = '#62584D',
		},
		inactive_tab_hover = {
			bg_color = '#DDD2C0',
			fg_color = '#4A433C',
		},
		new_tab = {
			bg_color = '#EAE0D1',
			fg_color = '#62584D',
		},
		new_tab_hover = {
			bg_color = '#DDD2C0',
			fg_color = '#4A433C',
		},
		inactive_tab_edge = '#BFB29D',
	},
}
