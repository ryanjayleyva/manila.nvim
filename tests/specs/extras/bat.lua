-- The bat themes are standalone .tmTheme files.

local P = require('helpers.palette')
local T = require('helpers')

return function()
	for _, name in ipairs(P.themes) do
		local colors = P.colors(P.palettes[name])

		local path = T.root .. '/extras/bat/manila-' .. name .. '.tmTheme'
		local content = T.read_file(path)
		if content then
			T.check(name .. ' bat theme reads', true)
			T.check(
				name .. ' bat theme has name',
				content:find('manila%-' .. name) ~= nil,
				'missing theme name'
			)
			T.check(
				name .. ' bat theme has background',
				content:find('<key>background</key>') ~= nil,
				'missing background'
			)
			T.check(
				name .. ' bat theme has foreground',
				content:find('<key>foreground</key>') ~= nil,
				'missing foreground'
			)
			P.check_content_colors(name .. ' bat', content, colors)
		else
			T.check(name .. ' bat theme reads', false, 'file missing')
		end
	end
end
