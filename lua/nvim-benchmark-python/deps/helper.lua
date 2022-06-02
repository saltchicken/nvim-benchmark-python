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
