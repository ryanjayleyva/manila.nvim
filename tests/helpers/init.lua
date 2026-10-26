-- Shared assertions and failure reporting for the smoke test specs.

local M = {}

M.root = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':p:h:h:h')
M.failures = {}
M.checks = 0

function M.check(name, ok, detail)
	M.checks = M.checks + 1
	if not ok then
		table.insert(M.failures, name .. (detail and (': ' .. detail) or ''))
	end
end

function M.eq(name, got, want)
	M.check(
		name,
		got == want,
		('got %s, want %s'):format(tostring(got), tostring(want))
	)
end

-- Return the file content, or nil when the file is missing.
function M.read_file(path)
	local file = io.open(path, 'r')
	if not file then
		return nil
	end
	local content = file:read('*a')
	file:close()
	return content
end

-- Print the failures and return whether every check passed.
function M.report()
	if #M.failures > 0 then
		io.stderr:write(('%d of %d checks failed:\n'):format(#M.failures, M.checks))
		for _, failure in ipairs(M.failures) do
			io.stderr:write('  - ' .. failure .. '\n')
		end
		return false
	end

	io.stdout:write(('%d checks passed\n'):format(M.checks))
	return true
end

return M
