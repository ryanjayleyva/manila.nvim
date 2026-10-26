-- Contrast against the background.

local L = require('helpers.lualine')
local P = require('helpers.palette')
local T = require('helpers')

local function luminance(color)
	local r, g, b = color:match('#(%x%x)(%x%x)(%x%x)')
	local function channel(value)
		value = value / 255
		if value <= 0.03928 then
			return value / 12.92
		end
		return ((value + 0.055) / 1.055) ^ 2.4
	end
	return 0.2126 * channel(tonumber(r, 16))
		+ 0.7152 * channel(tonumber(g, 16))
		+ 0.0722 * channel(tonumber(b, 16))
end

local function contrast(first, second)
	local high, low = luminance(first), luminance(second)
	if high < low then
		high, low = low, high
	end
	return (high + 0.05) / (low + 0.05)
end

return function()
	for _, name in ipairs(P.themes) do
		local palette = P.palettes[name]

		local text = contrast(palette.fg, palette.bg)
		T.check(
			('%s text contrast'):format(name),
			text >= 7,
			('%.2f:1, needs 7:1'):format(text)
		)

		local comment = contrast(palette.comment, palette.bg)
		T.check(
			('%s comment contrast'):format(name),
			comment >= 4.5,
			('%.2f:1, needs 4.5:1'):format(comment)
		)

		local theme = require('lualine.themes.manila-' .. name)
		for _, mode in ipairs(L.modes) do
			for _, key in ipairs({ 'a', 'b', 'c' }) do
				local section = theme[mode][key]
				local ratio = contrast(section.fg, section.bg)
				T.check(
					('%s lualine %s%s contrast'):format(name, mode, key),
					ratio >= 4.5,
					('%.2f:1, needs 4.5:1'):format(ratio)
				)
			end
		end
	end
end
