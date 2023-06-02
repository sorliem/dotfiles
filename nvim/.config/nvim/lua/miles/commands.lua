local _M = {}

vim.api.nvim_create_user_command("ViewSecret", function(args)
	local varname = args.fargs[1]
	local env = args.fargs[2]
	-- print("varname: " .. varname)
	-- print("env: " .. env)

	local url = "https://console.cloud.google.com/security/secret-manager/secret/"
		.. varname
		.. "/versions?project=onx-"
		.. env

	-- print("url: " .. url)
	vim.cmd(":!firefox '" .. url .. "'")
end, { nargs = "*" })

-- vim.keymap.set("n", "<leader>vs", ":ViewSecret<CR>", { desc = "[V]iew [S]ecret in GCP" })

return _M
