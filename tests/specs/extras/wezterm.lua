-- The WezTerm schemes are standalone files, so their colors are written out
-- instead of read from a palette. Keep them from drifting.

local P = require('helpers.palette')
local T = require('helpers')
local groups = require('manila.groups')

return function()
	for _, name in ipairs(P.extras) do
		local palette = P.palettes[name]
		local colors = P.colors(palette)

		local ok, scheme =
			pcall(dofile, T.root .. '/extras/wezterm/manila-' .. name .. '.lua')
		T.check(name .. ' WezTerm scheme loads', ok, tostring(scheme))

		if ok then
			local function check_colors(value)
				if type(value) == 'string' then
					T.check(
						('%s WezTerm color %s'):format(name, value),
						colors[value] == true,
						'not a palette color'
					)
				elseif type(value) == 'table' then
					for _, nested in pairs(value) do
						check_colors(nested)
					end
				end
			end
			check_colors(scheme)

			local terminal = groups.terminal_colors(palette)
			for index = 1, 8 do
				T.eq(
					('%s WezTerm ansi %d'):format(name, index - 1),
					scheme.ansi[index],
					terminal[index]
				)
				T.eq(
					('%s WezTerm bright %d'):format(name, index - 1),
					scheme.brights[index],
					terminal[index + 8]
				)
			end
		end
	end
end
