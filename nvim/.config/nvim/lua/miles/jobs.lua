local Job = require'plenary.job'

local _M = {}

_M.test_job = function()
  Job:new({
      command = 'echo',
      args = { 'hello_world' },
      cwd = '/usr/bin',
      env = { ['a'] = 'b' },
      on_exit = function(j, return_val)
        print("in on_exit")
        print(return_val)
        print(j:result())
      end,
    }):sync()
end

return _M
