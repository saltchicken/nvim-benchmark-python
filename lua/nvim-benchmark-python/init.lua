require("helper")

local M = {}

function M.create_tests(test_results, test_params)
	
	local file_path = vim.api.nvim_buf_get_name(0)
	local file_name = get_file_name(file_path)
	local import_name = file_name:sub(1, -4)

	if test_params == nil then test_params = "" end

	if file_exists("test_" .. file_name) then
		file = io.open("test_" .. file_name, "r")
		test_body = file:read("*all")
		file:close()
	else
		test_body = string.format('import %s', import_name) .. "\n\n"
	end

	local test_function = "def test_%s():\n\tassert %s.%s(%s) == %s"
	local function_name = get_function()
	if function_name ~= nil then
		test_body = test_body .. string.format(test_function, function_name, import_name, function_name, test_params, test_results) .. "\n"
	else
		print("Function not selected")
	end
	
	file = io.open("test_" .. file_name, "w")
	file:write(test_body)
	file:close()
	
	vim.api.nvim_command(":vsp test_" .. file_name)
end

return M
