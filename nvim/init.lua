-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Compile and run C++ program
function CompileAndRun()
    local fileName = vim.fn.expand('%')
    if fileName:match('%.cpp$') then
        local exeName = fileName:gsub('%.cpp$', '')
        vim.cmd('w')
        local compileCmd = 'silent !g++ -std=c++11 -Wall -Wextra -Wpedantic -O2 -o ' .. exeName .. ' ' .. fileName .. ' -lstdc++'
        vim.cmd(compileCmd)
        local runCmd = './' .. exeName
        local term_cmd = 'term ' .. runCmd
        vim.cmd(term_cmd)
        vim.cmd('wincmd p') -- Switch back to the code buffer
    else
        print('Not a C++ file')
    end
end

-- Map F5 key to compile and run current file
vim.api.nvim_set_keymap('n', '<F5>', ':lua CompileAndRun()<CR>', { noremap = true, silent = true })

