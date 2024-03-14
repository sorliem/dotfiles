return {
	{
		"jpalardy/vim-slime",
		branch = "main",
		config = function()
			if os.getenv("TMUX") then
				local tmux = os.getenv("TMUX")
				local t, sep = {}, ","
				for str in string.gmatch(tmux, "([^" .. sep .. "]+)") do
					table.insert(t, str)
				end

				vim.g.slime_paste_file = vim.fn.tempname()
				vim.g.slime_target = "tmux"
				vim.g.slime_default_config = { socket_name = t[1], target_pane = "{last}" }

				vim.g.slime_dont_ask_default = 1
			end
		end,
	},
}
