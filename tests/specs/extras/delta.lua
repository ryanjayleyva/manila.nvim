-- The delta themes are standalone gitconfig files.

local P = require('helpers.palette')
local T = require('helpers')

return function()
	for _, name in ipairs(P.extras) do
		local colors = P.colors(P.palettes[name])

		local path = T.root .. '/extras/delta/manila-' .. name .. '.gitconfig'
		local content = T.read_file(path)
		if content then
			T.check(name .. ' delta theme reads', true)
			T.check(
				name .. ' delta theme has feature',
				content:find('%[delta "manila%-' .. name .. '"%]') ~= nil,
				'missing feature section'
			)
			T.check(
				name .. ' delta theme sets syntax-theme',
				content:find('syntax%-theme = manila%-' .. name) ~= nil,
				'missing syntax-theme'
			)
			P.check_content_colors(name .. ' delta', content, colors)
		else
			T.check(name .. ' delta theme reads', false, 'file missing')
		end
	end
end
