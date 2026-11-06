-- Palette access and color validation shared by the specs.

local T = require('helpers')
local manila = require('manila')

local M = {}

M.themes = { 'day', 'night', 'noon' }

-- Themes that ship each integration. A theme joins the list of an integration
-- once its files exist, so the integrations can land one at a time.
M.extras = {
	lualine = { 'day', 'night', 'noon' },
	wezterm = { 'day', 'night', 'noon' },
	bat = { 'day', 'night' },
	fzf = { 'day', 'night' },
	tmux = { 'day', 'night' },
	delta = { 'day', 'night' },
}

M.palettes = {}
for _, name in ipairs(M.themes) do
	M.palettes[name] = require(manila.themes[name])
end

-- Collect the hex colors a palette defines.
function M.colors(palette)
	local colors = {}
	for _, value in pairs(palette) do
		if type(value) == 'string' and value:match('^#%x%x%x%x%x%x$') then
			colors[value] = true
		end
	end
	return colors
end

-- Every hex color in a standalone extra has to come from the palette.
function M.check_content_colors(label, content, colors)
	for color in content:gmatch('#(%x%x%x%x%x%x)') do
		local hx = '#' .. color:upper()
		T.check(
			('%s color %s'):format(label, hx),
			colors[hx] == true,
			'not a palette color'
		)
	end
end

return M
