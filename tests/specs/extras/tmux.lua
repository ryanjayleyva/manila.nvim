-- The tmux themes are standalone config files.

local P = require('helpers.palette')
local T = require('helpers')

return function()
	for _, name in ipairs(P.themes) do
		local colors = P.colors(P.palettes[name])

		local path = T.root .. '/extras/tmux/manila-' .. name .. '.conf'
		local content = T.read_file(path)
		if content then
			T.check(name .. ' tmux theme reads', true)
			T.check(
				name .. ' tmux theme sets status-style',
				content:find('set %-g status%-style') ~= nil,
				'missing status-style'
			)
			P.check_content_colors(name .. ' tmux', content, colors)
		else
			T.check(name .. ' tmux theme reads', false, 'file missing')
		end
	end
end
