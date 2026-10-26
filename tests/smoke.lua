-- Smoke test for manila.nvim.
-- Run with:
--   nvim --headless -l tests/smoke.lua
-- The script exits with a non zero status when a check fails.

local root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h')
vim.opt.runtimepath:prepend(root)
package.path = table.concat({
	root .. '/tests/?.lua',
	root .. '/tests/?/init.lua',
	package.path,
}, ';')

local T = require('helpers')

local specs = {
	'core',
	'contrast',
	'extras.lualine',
	'extras.wezterm',
	'extras.bat',
	'extras.fzf',
	'extras.tmux',
	'extras.delta',
}

-- An unexpected error fails the spec without stopping the others.
for _, name in ipairs(specs) do
	local ok, err = xpcall(function()
		require('specs.' .. name)()
	end, debug.traceback)
	if not ok then
		T.check('spec ' .. name .. ' runs', false, err)
	end
end

if not T.report() then
	os.exit(1)
end
