local M = {}

function M.create_tests()
	file = io.open("test_.py", "w")
	file:write([[
def func(x):
	return x + 1

def test_answer():
	assert func(3) == 5
		]])
	file:close()
end
return M
