local M = {}

function get_file_name(file)
	return file:match("^.+/(.+)$")
end

function M.create_tests()
	local file_name = vim.fn.expand('%')
	-- local file_name = get_file_name(vim.fn.expand('%'))
	-- print(file_name)
	file = io.open("test_" .. file_name, "w")
	file:write([[
def func(x):
	return x + 1

def test_answer():
	assert func(3) == 5
		]])
	file:close()
	-- print(vim.api.nvim_buf_get_name(0))
	vim.api.nvim_command(":vsp test_" .. file_name)
end

return M
