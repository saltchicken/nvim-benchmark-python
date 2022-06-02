require("helper")

local M = {}

function M.create_tests(test_params, test_results)
	
	-- print(test_params, test_results)

	-- Get current file name, path, and import name.
	local file_path = vim.api.nvim_buf_get_name(0)
	local file_name = get_file_name(file_path)
	local import_name = file_name:sub(1, -4)

	-- Get current cursor position.
	-- print(cursor_row, cursor_column)

	-- Iterate through lines to find function names. Assign to funcs. 
	lines = vim.api.nvim_buf_get_lines(1, 0, -1, true)
	funcs = {}
	for i, j in ipairs(lines) do
		if string.find(j, "def") then
			local func = string.match(j, ".+%(")
			func = func:gsub("%s+", "")
			table.insert(funcs, func:sub(4, -2) )
			
			local param_count, params = get_parameters(j)
			-- print(param_count, params)
		end
	end
	local test_body = string.format('import %s', import_name) .. "\n\n"

	-- Iterate through function names and create test functions. Append to test_body.
	for i, j in ipairs(funcs) do
		local test_function = [[
def test_%s():
	assert %s.%s() == True
		]]
		test_body = test_body .. string.format(test_function, j, import_name, j) .. "\n"
	end
	
	
	file = io.open("test_" .. file_name, "w")
	file:write(test_body)
	file:close()
	
	vim.api.nvim_command(":vsp test_" .. file_name)
end

return M
