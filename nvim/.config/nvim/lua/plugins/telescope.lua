return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	keys = {
		{ "<C-p>" },
		{ "<leader>ps" },
		{ "<leader>ofs" },
		{ "<leader>ofw" },
	},
	config = function()
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local action_layout = require("telescope.actions.layout")
		local previewers = require("telescope.previewers")
		local pickers = require("telescope.pickers")
		local sorters = require("telescope.sorters")
		local finders = require("telescope.finders")
		local themes = require("telescope.themes")

		local function tmux_command(command)
			local tmux_socket = vim.fn.split(vim.env.TMUX, ",")[1]
			return vim.fn.system("tmux -S " .. tmux_socket .. " " .. command)
		end

		local open_file_in_tmux_session = function(prompt_bufnr)
			local current_picker = action_state.get_current_picker(prompt_bufnr) -- picker state
			local entry = action_state.get_selected_entry()

			if not entry then
				return
			end

			local meta = getmetatable(entry)

			if string.match(meta.cwd, "onxmaps") then
				local repo = string.match(entry.filename, "([^/]+)")
				local lnum = entry.lnum
				local position = string.find(entry.filename, "/")
				local trimmed_filename = position and string.sub(entry.filename, position + 1) or entry.filename
				local vim_cmd = string.format("vim +%s %s", lnum, trimmed_filename)
				local has_session = tmux_command("has-session -t=" .. repo .. " 2> /dev/null")

				if has_session == 0 then
					-- session exists, send vim command and switch to client
					actions.close(prompt_bufnr)

					-- suspend current vim session if active with C-z
					tmux_command(string.format("send-keys -t=%s:%s.1 C-z", repo, repo))
					-- tmux_command(string.format("send-keys -t=%s:%s.1 '%s'", repo, repo, vim_cmd))
					tmux_command("switch-client -t=" .. repo)
				else
					-- session does not exist, create session, send vim command and switch to client
					-- tmux_command("new-session -ds " .. repo .. " -c $HOME/gitroot/onxmaps/" .. repo .. " -n " .. repo)
					actions.close(prompt_bufnr)
					tmux_command(
						string.format("new-session -ds %s -c $HOME/gitroot/onxmaps/%s -n %s", repo, repo, repo)
					)

					tmux_command(string.format("send-keys -t=%s:%s.1 '%s' C-m", repo, repo, vim_cmd))
					tmux_command("switch-client -t=" .. repo)
				end
			end
		end

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
						["<C-s>"] = actions.cycle_previewers_next,
						["<C-a>"] = actions.cycle_previewers_prev,
						["<M-p>"] = action_layout.toggle_preview,
						["<C-Q>"] = actions.send_to_qflist + actions.open_qflist,
						-- ["<C-X>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-space>"] = actions.to_fuzzy_refine,
						["<C-t>"] = open_file_in_tmux_session,
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
				git_commits = {
					git_command = {
						"git",
						"log",
						"--all",
						"--pretty=%h %<(10,trunc) %an %<(33,trunc) %s (%cr)",
						"--",
						".",
					},
					previewers = {
						previewers.git_commit_message.new({}),
						previewers.git_commit_diff_as_was.new({}),
					},
				},
				git_bcommits = {
					git_command = { "git", "log", "--pretty=%h %<(10,trunc) %an %<(33,trunc) %s (%cr)" },
					previewers = {
						previewers.git_commit_message.new({}),
						previewers.git_commit_diff_as_was.new({}),
					},
				},
				live_grep = {
					additional_args = function( --[[opts]])
						return { "--hidden", "--ignore-case", "--glob", "'!*README.md'" }
					end,
				},
				colorscheme = {
					enable_preview = false,
				},
				buffers = {
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer + actions.move_to_top,
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
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
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("git_worktree")
		require("telescope").load_extension("advanced_git_search")
		require("telescope").load_extension("emoji")
		-- require("telescope").load_extension("yank_history")
		require("telescope").load_extension("harpoon")
		require("telescope").load_extension("luasnip")

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
			require("telescope.builtin").buffers({ sort_mru = true })
		end)

		vim.keymap.set("n", "<leader>ht", function()
			require("telescope.builtin").help_tags()
		end)

		-- similar to alternate buffer motion
		vim.keymap.set("n", "<leader>t6", function()
			require("telescope.builtin").resume()
		end)

		vim.keymap.set("n", "<leader>gb", function()
			require("telescope.builtin").git_branches()
		end)

		vim.keymap.set("n", "<leader>ghr", function()
			require("miles.telescope_functions").github_pull_requests()
		end, { desc = "List Recent [G]it[H]ub Pull [R]equests" })

		-- vim.api.nvim_create_user_command("GhList", function()
		-- 	require("miles.telescope_functions").github_pull_requests()
		-- end, {})

		vim.keymap.set("n", "<leader>km", function()
			require("telescope.builtin").keymaps({ show_plug = false })
		end, { desc = "[K]ey [M]aps" })

		vim.keymap.set("n", "z=", function()
			require("telescope.builtin").spell_suggest()
		end, { desc = "Spell Suggest w/ Telescope" })

		vim.keymap.set("n", "<leader>fw", function()
			require("telescope.builtin").grep_string({ additional_args = { "--hidden", "--glob", "!README.md" } })
		end, { desc = "[F]ind [W]ord (telescope)" })

		vim.keymap.set("n", "<leader>ofw", function()
			local ft = vim.bo.ft
			local search_word = vim.fn.expand("<cword>")
			local additional_args = { "--hidden" }

			local mappings = {
				terraform = "tf",
				dockerfile = "docker",
				eelixir = "elixir",
				nginx = "config",
				template = "config",
			}

			ft = mappings[ft] or ft
			vim.list_extend(additional_args, { "--type", ft, "--type-add", "tf:*tfvars" })

			require("telescope.builtin").grep_string({
				additional_args = additional_args,
				cwd = "~/gitroot/onxmaps",
				prompt_title = string.format("Find [%s] in all [%s] OnX Files", search_word, ft),
			})
		end, { desc = "[O]nX [F]ind [W]ord (telescope)" })

		vim.keymap.set("n", "<leader>gm", function()
			require("telescope.builtin").git_commits()
		end, { desc = "Telescope [G]it Co[m]mits" })

		vim.keymap.set("n", "<leader>bb", function()
			require("telescope.builtin").git_bcommits()
		end, { desc = "Telescope [Bb]uffer Commits, not a great mnemonic" })

		vim.keymap.set("n", "<leader>gw", function()
			require("telescope").extensions.git_worktree.git_worktrees()
		end, { desc = "[G]it [W]orktrees" })

		vim.keymap.set("n", "<leader>gaw", function()
			require("telescope").extensions.git_worktree.create_git_worktree()
		end, { desc = "[G]it [A]dd [W]orktree" })

		vim.keymap.set("n", "<leader>ps", function()
			local additional_args = {}
			vim.list_extend(additional_args, { "--glob", "!README.md" })
			vim.list_extend(additional_args, { "--hidden", "--ignore-case" })

			local opts = {
				file_ignore_patterns = { ".git" },
				additional_args = additional_args,
			}

			require("telescope.builtin").live_grep(opts)
		end, { desc = "[P]roject [S]earch with rg" })

		vim.keymap.set("n", "<leader>ofs", function()
			require("miles.telescope_functions").onx_live_grep()
		end, { desc = "[O]nx [F]ile Live Grep [S]earch by file type" })

		vim.keymap.set("n", "//", function()
			require("telescope.builtin").current_buffer_fuzzy_find({
				previewer = false,
			})
		end, { desc = "Fuzzy find over buffer lines" })

		vim.keymap.set("n", "<leader>ji", function()
			require("miles.telescope_functions").jira_tickets()
		end, { desc = "[J][i]ra ticket list" })

		vim.keymap.set("n", "<leader>mp", function()
			require("telescope.builtin").man_pages()
		end, { desc = "[M]an [P]ages" })

		vim.keymap.set("n", "<leader>lc", function()
			require("telescope.builtin").commands()
		end, { desc = "[L]ist [C]ommands" })

		vim.keymap.set("n", "<leader>tls", function()
			require("telescope").extensions.luasnip.luasnip({})
		end, { desc = "[T]elescope [L]ua[S]nip" })

		vim.keymap.set("n", "<leader>tfs", function()
			local workspace = vim.fn.system("terraform workspace show"):gsub("\n", "")
			pickers
				.new({
					prompt_title = "Terraform state show",
					results_title = string.format("Resources (%s)", workspace),
					finder = finders.new_oneshot_job({ "terraform", "state", "list" }),
					sorter = sorters.get_fuzzy_file(),
					previewer = previewers.new_buffer_previewer({
						define_preview = function(self, entry, status)
							return require("telescope.previewers.utils").job_maker(
								{ "terraform", "state", "show", entry.value },
								self.state.bufnr,
								{
									callback = function(bufnr, content)
										if content ~= nil then
											require("telescope.previewers.utils").regex_highlighter(bufnr, "terraform")
										end
									end,
								}
							)
						end,
					}),
				})
				:find()
		end, { desc = "[T]erra[f]orm State [S]how w/ Telescope" })
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"xiyaowong/telescope-emoji.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
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
		{
			"benfowler/telescope-luasnip.nvim",
			config = function() end,
		},
	},
}
