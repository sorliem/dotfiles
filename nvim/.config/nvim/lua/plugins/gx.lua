return {
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		event = "VeryLazy",
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		submodules = false, -- not needed, submodules are required only for tests
		config = function()
			require("gx").setup({
				open_browser_app = "open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
				open_browser_args = {},    -- specify any arguments, such as --background for macOS' "open".
				handlers = {
					plugin = true,            -- open plugin links in lua (e.g. packer, lazy, ..)
					github = true,            -- open github issues
					brewfile = true,          -- open Homebrew formulaes and casks
					package_json = true,      -- open dependencies from package.json
					search = true,            -- search the web/selection on the web if nothing else is found
					go = true,                -- open pkg.go.dev from an import statement (uses treesitter)
					rust = {                  -- custom handler to open rust's cargo packages
						name = "rust",           -- set name of handler
						filetype = { "toml" },   -- you can also set the required filetype for this handler
						filename = "Cargo.toml", -- or the necessary filename
						handle = function(mode, line, _)
							local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

							if crate then
								return "https://crates.io/crates/" .. crate
							end
						end,
					},
					terraform = {
						name = "terraform",
						-- filetype = { "terraform" },
						filename = "*.tf",
						handle = function(mode, line, _)
							print("tf line = " .. vim.inspect(line))
							local resource = require("gx.helper").find(line, mode, '"(%w+)"')

							if resource then
								return "https://registry.terraform.io/?q=" .. resource
							end
						end,
					},
					jira = {        -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
						name = "jira", -- set name of handler
						handle = function(mode, line, _)
							local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
							if ticket and #ticket < 20 then
								return "http://onxmaps.atlassian.net/browse/" .. ticket
							end
						end,
					},
					elixir = {             -- custom handler to open rust's cargo packages
						name = "elixir",      -- set name of handler
						filename = "mix.exs", -- or the necessary filename
						handle = function(mode, line, _)
							local package = require("gx.helper").find(line, mode, "%s+{:(%w+)},.*$")
							print("line = " .. vim.inspect(line))
							print("mode = " .. vim.inspect(mode))
							print("package = " .. vim.inspect(package))

							if package then
								return "https://hex.pm/packages/" .. package
							end
						end,
					},
				},
				handler_options = {
					search_engine = "duckduckgo",           -- or you can pass in a custom search engine
					select_for_search = false,              -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link
					git_remotes = { "upstream", "origin" }, -- list of git remotes to search for git issue linking, in priority
					git_remote_push = false,                -- use the push url for git issue linking,
				},
			})
		end,
	},
}
