local M = {}

function get_file_name(file)
	return file:match("^.+/(.+)$")
end

function M.create_tests()
	
	local test_body = ''

	lines = vim.api.nvim_buf_get_lines(1, 0, -1, true)
	funcs = {}
	for i, j in ipairs(lines) do
		if string.find(j, "def") then
			table.insert(funcs, j)
		end
	end
	for i, j in ipairs(funcs) do
		local test_function = [[
def test_%s:
	assert func(3) == 5
		]]
		test_body = test_body .. string.format(test_function, j) .. "\n"
	end
	
	local file_name = vim.fn.expand('%')
	-- local file_name = get_file_name(vim.fn.expand('%'))
	-- print(vim.api.nvim_buf_get_name(0))
	
	file = io.open("test_" .. file_name, "w")
	file:write(test_body)
	file:close()
	
	vim.api.nvim_command(":vsp test_" .. file_name)
end

return M
