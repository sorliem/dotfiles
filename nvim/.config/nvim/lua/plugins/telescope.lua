return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local actions = require("telescope.actions")
		local action_layout = require("telescope.actions.layout")

		require("telescope").setup({
			defaults = {
				file_sorter = require("telescope.sorters").get_fzf_sorter,
				prompt_prefix = " > ",
				color_devicons = true,
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				scroll_strategy = "cycle",
				preview = {
					filesize_limit = 10,
				},
				file_ignore_patterns = {
					".git",
				},
				layout_config = {
					width = 0.85,
					height = 0.85,
					preview_cutoff = 160,
					prompt_position = "top",
					horizontal = {
						preview_width = function(_, cols, _)
							if cols > 200 then
								return math.floor(cols * 0.5)
							else
								return math.floor(cols * 0.5)
							end
						end,
					},

					vertical = {
						width = 0.7,
						height = 0.85,
						preview_height = 0.5,
					},

					flex = {
						horizontal = {
							preview_width = 0.9,
						},
					},
				},
				mappings = {
					i = {
						-- close on escape
						["<esc>"] = actions.close,
						["<tab>"] = actions.toggle_selection + actions.move_selection_next,
						["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
						["<C-Down>"] = require("telescope.actions").cycle_history_next,
						["<C-Up>"] = require("telescope.actions").cycle_history_prev,
						["<M-p>"] = action_layout.toggle_preview,
						["<C-w>"] = function()
							vim.cmd([[normal! bcw]])
						end,
					},
					n = {
						["<tab>"] = actions.toggle_selection + actions.move_selection_next,
						["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
						["<M-p>"] = action_layout.toggle_preview,
					},
				},
			},
			pickers = {
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
			},
			extensions = {
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("git_worktree")

		local search_wiki = function()
			require("telescope.builtin").find_files({
				prompt_title = "< Personal VimWiki >",
				cwd = "~/vimwiki",
				hidden = true,
			})
		end

		-- search git files and if not successful do a regular find files
		local project_files = function()
			local opts = {}
			local ok = pcall(require("telescope.builtin").git_files, opts)
			if not ok then
				require("telescope.builtin").find_files({ prompt_title = "Non-git files" })
			end
		end

		local reload_lua_modules = function()
			-- From https://ustrajunior.com/posts/reloading-neovim-config-with-telescope/
			local function get_module_name(s)
				local module_name

				module_name = s:gsub("%.lua", "")
				module_name = module_name:gsub("%/", ".")
				module_name = module_name:gsub("%.init", "")

				return module_name
			end

			local prompt_title = "~ neovim modules ~"

			-- sets the path to the lua folder
			local path = "~/.config/nvim/lua"

			local opts = {
				prompt_title = prompt_title,
				cwd = path,

				attach_mappings = function(_, map)
					-- Adds a new map to ctrl+e.
					map("i", "<c-e>", function(_)
						-- these two a very self-explanatory
						local entry = require("telescope.actions.state").get_selected_entry()
						local name = get_module_name(entry.value)

						-- call the helper method to reload the module
						-- and give some feedback
						R(name)
						P(name .. " RELOADED!!!")
					end)

					return true
				end,
			}

			-- call the builtin method to list files
			require("telescope.builtin").find_files(opts)
		end

		vim.keymap.set("n", "<C-P>", function()
			print("IN KEYMAP")
			project_files()
		end, { desc = "Project files (Git or non-git)" })
		vim.keymap.set("n", "<leader>ws", search_wiki, { desc = "[W]iki [S]earch" })
		vim.keymap.set("n", "<leader><leader>", ":lua require('telescope.builtin').buffers()<CR>")
		vim.keymap.set("n", "<leader>ht", ":lua require('telescope.builtin').help_tags()<CR>")
		vim.keymap.set("n", "<leader>gc", ":lua require('telescope.builtin').git_branches()<CR>")
		vim.keymap.set("n", "<Leader>qr", reload_lua_modules, { desc = "Reload lua modules" })

		vim.keymap.set("n", "<leader>km", function()
			require("telescope.builtin").keymaps({ show_plug = false })
		end, { desc = "[K]ey [M]aps" })

		vim.keymap.set(
			"n",
			"<leader>fw",
			":lua require('telescope.builtin').grep_string{}<CR>",
			{ desc = "[F]ind [W]ord (telescope)" }
		)

		vim.keymap.set("n", "<leader>gm", function()
			local git_commits_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--", "." }
			require("telescope.builtin").git_commits({ git_command = git_commits_command })
		end)
		--
		vim.keymap.set("n", "<leader>gm", ":lua require('telescope.builtin').git_commits()<CR>")

		vim.keymap.set("n", "<leader>gf", ":lua require('telescope.builtin').git_status()<CR>")

		-- git worktrees
		vim.keymap.set(
			"n",
			"<leader>gw",
			":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
			{ desc = "[G]it [W]orktrees" }
		)
		vim.keymap.set(
			"n",
			"<leader>gaw",
			":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
			{ desc = "[G]it [A]dd [W]orktree" }
		)
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			branch = "main",
		},
	},
}
