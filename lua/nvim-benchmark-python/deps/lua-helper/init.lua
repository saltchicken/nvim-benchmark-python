function get_file_name(file)
	return file:match("^.+/(.+)$")
end

function get_parameters(func_line)
	local params = string.match(func_line, "%(.+%)")
	if params == nil then
		return nil
	end
	params = params:sub(2, -2)
	local commas = {}
	local comma_index = 0
	local param_count = 1
	while true do
		comma_index = string.find(params, ",", comma_index + 1)
		if comma_index == nil then break end
		table.insert(commas, comma_index)
		param_count = param_count + 1
	end
	-- print(unpack(commas))
	-- print(param_count)
	return param_count, params

end

function get_function()
	local cursor_row, cursor_column = unpack(vim.api.nvim_win_get_cursor(0))
	lines = vim.api.nvim_buf_get_lines(1, 0, -1, true)
	for index, line in ipairs(lines) do
		if index == cursor_row then
			if string.find(line, "def") then
				local func = string.match(line, ".+%(")
				func = func:gsub("%s+", "")
				return func:sub(4, -2)
			end
		end
	end
	return nil
end
