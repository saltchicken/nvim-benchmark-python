if exists("g:loaded_nvimbenchmarkpython")
    finish
endif
let g:loaded_nvimbenchmarkpython = 1

let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/nvim-benchmark-python/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

"command! -nargs=0 CreateTests lua require("nvim-benchmark-python").create_tests()
command! -nargs=* CreateTests lua require("nvim-benchmark-python").create_tests(<f-args>)
