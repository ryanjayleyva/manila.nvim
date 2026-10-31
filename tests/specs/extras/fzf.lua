-- The fzf themes are standalone shell scripts.

local P = require('helpers.palette')
local T = require('helpers')

return function()
	for _, name in ipairs(P.extras) do
		local colors = P.colors(P.palettes[name])

		local path = T.root .. '/extras/fzf/manila-' .. name .. '.sh'
		local content = T.read_file(path)
		if content then
			T.check(name .. ' fzf theme reads', true)
			T.check(
				name .. ' fzf theme sources FZF_DEFAULT_OPTS',
				content:find('FZF_DEFAULT_OPTS') ~= nil,
				'missing FZF_DEFAULT_OPTS'
			)
			T.check(
				name .. ' fzf theme uses color',
				content:find('%-%-color=') ~= nil,
				'missing --color'
			)
			P.check_content_colors(name .. ' fzf', content, colors)
		else
			T.check(name .. ' fzf theme reads', false, 'file missing')
		end
	end
end
