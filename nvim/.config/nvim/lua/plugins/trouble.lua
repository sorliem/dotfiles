return {
	"folke/trouble.nvim",
	cond = false,
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		require("trouble").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		})

		vim.keymap.set("n", "<leader>xx", function()
			require("trouble").open()
		end)
		vim.keymap.set("n", "<leader>xw", function()
			require("trouble").open("workspace_diagnostics")
		end)
		vim.keymap.set("n", "<leader>xd", function()
			require("trouble").open("document_diagnostics")
		end)
		vim.keymap.set("n", "<leader>xq", function()
			require("trouble").open("quickfix")
		end)
		vim.keymap.set("n", "<leader>xl", function()
			require("trouble").open("loclist")
		end)
		vim.keymap.set("n", "gR", function()
			require("trouble").open("lsp_references")
		end)

		vim.keymap.set("n", "[t", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end)

		vim.keymap.set("n", "]t", function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end)

		-- vim.keymap.set("n", "<leader>tt", ":TroubleToggle<CR>")
	end,
}
