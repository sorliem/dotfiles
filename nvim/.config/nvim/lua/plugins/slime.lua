return {
	{
		"jpalardy/vim-slime",
		branch = "main",
		config = function()
			if os.getenv("$TMUX") then
				local tmux = os.getenv("$TMUX")
				local t = {}
				local sep = ","
				for str in string.gmatch(tmux, "([^" .. sep .. "]+)") do
					table.insert(t, str)
				end

				vim.g.slime_target = "tmux"
				vim.g.slime_default_config = { socket_name = sep[1], target_pane = "3" }

				vim.g.slime_dont_ask_default = 1
			end
		end,
	},
}
