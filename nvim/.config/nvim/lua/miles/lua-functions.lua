find_repo_or_cmd = function(findstr, cmd)
	print("findstr = " .. vim.inspect(findstr))
	local res = vim.fn.search(findstr)
	print("res = " .. vim.inspect(res))
	if res == 0 then
		vim.cmd(cmd)
	end
end



vim.api.nvim_create_user_command("ReplaceIfStrNotFound", function(args)
	local str = args.fargs[1]
	local cmd = args.fargs[2]
	print("str = " .. vim.inspect(str))
	print("cmd = " .. vim.inspect(cmd))
	find_repo_or_cmd(str, cmd)
end, {})
