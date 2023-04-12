return {
	"nvim-telescope/telescope.nvim",
	keys = {
		-- load telescope on these keymappings
		{ "<C-p>" },
		{ "<Leader>ht" },
		-- { "<Leader>km" },
		{
			"<leader>km",
			function()
				require("telescope.builtin").keymaps({ show_plug = false })
			end,
			desc = "[K]ey [M]aps",
		},
		{ "<Leader>gm" },
		{ "<Leader>fw" },
		{ "<Leader>ps" },
	},
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
				live_grep = {
					additional_args = function(--[[opts]])
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
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("git_worktree")
		require("telescope").load_extension("emoji")

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

		vim.keymap.set("n", "<C-P>", project_files, { desc = "Project files (Git or non-git)" })
		vim.keymap.set("n", "<leader>ws", search_wiki, { desc = "[W]iki [S]earch" })
		vim.keymap.set("n", "<leader>ns", norg_search, { desc = "Work [N]org [S]earch" })
		vim.keymap.set("n", "<leader><leader>", ":lua require('telescope.builtin').buffers()<CR>")
		vim.keymap.set("n", "<leader>ht", ":lua require('telescope.builtin').help_tags()<CR>")
		vim.keymap.set("n", "<leader>gc", ":lua require('telescope.builtin').git_branches()<CR>")

		-- vim.keymap.set("n", "<leader>km", function()
		-- 	require("telescope.builtin").keymaps({ show_plug = false })
		-- end, { desc = "[K]ey [M]aps" })

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
		-- vim.keymap.set("n", "//", ":lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")

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

		vim.keymap.set(
			"n",
			"<leader>ps",
			":lua require('telescope.builtin').live_grep()<CR>",
			{ desc = "[P]roject [S]earch with rg" }
		)

		vim.keymap.set("n", "<leader>ji", function()
			vim.cmd([[Easypick myjira]])
		end, { desc = "[J][i]ra ticket list" })
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"xiyaowong/telescope-emoji.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			branch = "main",
		},
	},
}
