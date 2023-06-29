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
				file_ignore_patterns = {},
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
						["<C-Down>"] = actions.cycle_history_next,
						["<C-Up>"] = actions.cycle_history_prev,
						["<M-p>"] = action_layout.toggle_preview,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<C-w>"] = function()
							-- delete previous word
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
				live_grep = {
					additional_args = function( --[[opts]])
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				advanced_git_search = {
					-- fugitive or diffview
					diff_plugin = "fugitive",
					-- customize git in previewer
					-- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
					git_flags = {},
					-- customize git diff in previewer
					-- e.g. flags such as { "--raw" }
					git_diff_flags = {},
					-- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
					show_builtin_git_pickers = false,
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("git_worktree")
		require("telescope").load_extension("advanced_git_search")
		require("telescope").load_extension("emoji")
		require("telescope").load_extension("yank_history")

		local search_wiki = function()
			require("telescope.builtin").find_files({
				prompt_title = "< Personal VimWiki >",
				cwd = "~/vimwiki",
				hidden = true,
			})
		end

		local norg_search = function()
			require("telescope.builtin").find_files({
				prompt_title = "< Work Norg Files >",
				cwd = "~/notes/work",
				hidden = true,
			})
		end

		-- search git files and if not successful do a regular find files
		local project_files = function()
			local opts = { show_untracked = true }
			local ok = pcall(require("telescope.builtin").git_files, opts)
			if not ok then
				require("telescope.builtin").find_files({ prompt_title = "Non-git files" })
			end
		end

		vim.keymap.set("n", "<C-P>", project_files, { desc = "Project files (Supports Git & non-git)" })
		vim.keymap.set("n", "<leader>ws", search_wiki, { desc = "[W]iki [S]earch" })
		vim.keymap.set("n", "<leader>ns", norg_search, { desc = "Work [N]org [S]earch" })

		vim.keymap.set("n", "<leader><leader>", function()
			require("telescope.builtin").buffers()
		end)

		vim.keymap.set("n", "<leader>ht", function()
			require("telescope.builtin").help_tags()
		end)

		vim.keymap.set("n", "<leader>gc", function()
			require("telescope.builtin").git_branches()
		end)

		vim.keymap.set("n", "<leader>km", function()
			require("telescope.builtin").keymaps({ show_plug = false })
		end, { desc = "[K]ey [M]aps" })

		vim.keymap.set("n", "<leader>fw", function()
			require("telescope.builtin").grep_string({ additional_args = { "--hidden" } })
		end, { desc = "[F]ind [W]ord (telescope)" })

		vim.keymap.set("n", "<leader>ofw", function()
			local ft = vim.bo.ft
			local search_word = vim.fn.expand("<cword>")

			if ft == "terraform" then
				ft = "tf"
			end

			local prompt_title = "Find [" .. search_word .. "] in all [" .. ft .. "] OnX Files"

			require("telescope.builtin").grep_string({
				additional_args = { "--hidden", "--type", ft },
				cwd = "~/gitroot/onxmaps",
				prompt_title = prompt_title,
			})
		end, { desc = "[O]nX [F]ind [W]ord (telescope)" })

		vim.keymap.set("n", "<leader>gm", function()
			local git_commits_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--", "." }
			require("telescope.builtin").git_commits({ git_command = git_commits_command })
		end)
		--
		vim.keymap.set("n", "<leader>gm", function()
			require("telescope.builtin").git_commits()
		end)

		-- vim.keymap.set("n", "//", function()
		-- 	require("telescope.builtin").current_buffer_fuzzy_find({
		-- 		sorter = require("telescope.sorters").get_substr_matcher({}),
		-- 	})
		-- 	-- require('telescope.builtin').current_buffer_fuzzy_find()
		-- end)

		-- git worktrees
		vim.keymap.set("n", "<leader>gw", function()
			require("telescope").extensions.git_worktree.git_worktrees()
		end, { desc = "[G]it [W]orktrees" })

		vim.keymap.set("n", "<leader>gaw", function()
			require("telescope").extensions.git_worktree.create_git_worktree()
		end, { desc = "[G]it [A]dd [W]orktree" })

		vim.keymap.set("n", "<leader>ps", function()
			-- tip: when grepping, <c-space> will pin that search and you can refine from there
			-- require("telescope").extensions.live_grep_args.live_grep_args()
			-- require("telescope.builtin").grep_string({
			-- shorten_path = true,
			-- word_match = "-w",
			-- only_sort_text = true,
			-- search = "",
			-- 	prompt_title = "Grep String (fzf style)",
			-- 	additional_args = function(--[[opts]])
			-- 		return { "--hidden" }
			-- 	end,
			-- })
			require("telescope.builtin").live_grep({
				file_ignore_patterns = { ".git" },
				additional_args = function( --[[opts]])
					return { "--hidden" }
				end,
			})
		end, { desc = "[P]roject [S]earch with rg" })

		vim.keymap.set("n", "<leader>ofs", function()
			require("miles.telescope_functions").onx_live_grep()
		end, { desc = "[O]nx [F]ile Live Grep [S]earch by file type" })

		vim.keymap.set("n", "//", function()
			require("telescope.builtin").current_buffer_fuzzy_find()
		end, { desc = "Fuzzy find over buffer lines" })

		vim.keymap.set("n", "<leader>ji", function()
			require("miles.telescope_functions").jira_tickets()
		end, { desc = "[J][i]ra ticket list" })

		vim.keymap.set("n", "<leader>lc", function()
			require("telescope.builtin").commands()
		end, { desc = "[L]ist [C]ommands" })
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"xiyaowong/telescope-emoji.nvim",
		{
			"aaronhallaert/advanced-git-search.nvim",
			config = function()
				vim.keymap.set("n", "<leader>ags", ":AdvancedGitSearch<CR>", { desc = "[A]dvanced [G]it [S]earch" })
			end,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			branch = "main",
		},
	},
}
