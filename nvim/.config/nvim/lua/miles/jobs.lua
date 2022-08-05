local Job = require('plenary.job')

local _M = {}

_M.run_test = function()
    local filepath = vim.fn.expand('%:')
    local cwd = vim.fn.getcwd()
    Job:new({
            command = 'docker-compose',
            args = { 'run', '--rm', 'test' },
            cwd = cwd,
            env = { },
            on_exit = function(j, return_val)
                print(vim.inspect(return_val))
                print(vim.inspect(j:result()))
            end,
        }):start() -- or start()
end

return _M
