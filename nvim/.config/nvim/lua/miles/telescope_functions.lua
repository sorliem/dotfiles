local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local themes = require("telescope.themes")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local utils = require("telescope.utils")
local make_entry = require("telescope.make_entry")

local _M = {}

_M.onx_live_grep = function(opts)
	local ft = vim.fn.input("File type(s) to search onx files for (comma-delimited): ")
	local delimiter = ","
	local additional_args_list = {}
	local startIndex = 1

	if ft == "" then
		ft = "tf (default)"
		vim.list_extend(additional_args_list, { "--type", "tf" })
	else
		-- gross string split, thanks to chatgpt
		while true do
			local endIndex = string.find(ft, delimiter, startIndex)

			if endIndex == nil then
				vim.list_extend(additional_args_list, { "--type", string.sub(ft, startIndex) })
				break
			end

			vim.list_extend(additional_args_list, { "--type", string.sub(ft, startIndex, endIndex - 1) })
			startIndex = endIndex + 1
		end
	end

	-- add additional typespec for tfvars files that is not built into ripgrep
	vim.list_extend(additional_args_list, { "--type-add", "tf:*.tfvars" })

	-- ignore README.md files
	vim.list_extend(additional_args_list, { "--glob", "!README.md" })

	-- search hidden files and directories
	vim.list_extend(additional_args_list, { "--hidden" })

	require("telescope.builtin").live_grep({
		cwd = "~/gitroot/onxmaps",
		additional_args = additional_args_list,
		prompt_title = "Live Grep all [" .. ft .. "] OnX Files",
	})
end

_M.live_multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local pieces = vim.split(prompt, "  ") -- double space
			local args = { "rg" }
			if pieces[1] then
				table.insert(args, "--regexp")
				table.insert(args, pieces[1])
			end

			if pieces[2] then
				table.insert(args, "--glob")
				table.insert(args, pieces[2])
			end

			---@diagnostic disable-next-line: deprecated
			return vim.tbl_flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Multi Grep",
			default_text = "  *.tf",
			finder = finder,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

-- our picker function: colors
_M.jira_tickets = function(opts)
	-- cron task outputs to tmp file
	local file = io.open("/tmp/jira-issues.txt", "r")

	if not file then
		print("FILE NOT FOUND: /tmp/jira-issues.txt")
	end
	local output = file:read("*a")
	file:close()

	local raw_lines = {}
	for s in output:gmatch("[^\r\n]+") do
		table.insert(raw_lines, s)
	end

	table.remove(raw_lines, 1) -- remove CSV header

	local results_out = {}

	for _, item in ipairs(raw_lines) do
		local jira_ticket_details = {}
		for s in string.gmatch(item, "([^\t]+)") do
			table.insert(jira_ticket_details, s)
		end
		table.insert(results_out, jira_ticket_details)
	end

	opts = opts or themes.get_dropdown({}) -- fix!!
	pickers
		.new(opts, {
			prompt_title = "Miles' OnX Jira",
			finder = finders.new_table({
				results = results_out,
				entry_maker = function(entry)
					return {
						value = "JIRA https://onxmaps.atlassian.net/browse/" .. entry[1],
						display = entry[1] .. "[" .. entry[2] .. "]: " .. entry[3],
						ordinal = entry[1] .. " - " .. entry[2] .. " " .. entry[3],
						ticket_num = entry[1],
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<C-y>", function(prompt_bufnr2)
					actions.close(prompt_bufnr2)
					local selection = action_state.get_selected_entry()
					print("selection = ", vim.inspect(selection))
					vim.api.nvim_put({ selection.ticket_num }, "", false, true)
				end)

				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.api.nvim_put({ selection.value }, "", false, true)
				end)
				return true
			end,
		})
		:find()
end

_M.github_pull_requests = function(opts)
	local output = utils.get_os_command_output({
		"gh",
		"search",
		"prs",
		"--author=@me",
		"--limit=50",
		"--json=title,number,repository,state,title,updatedAt",
		"--template",
		"'{{range .}}{{.number}}|{{.state}}|{{.title}}|{{.repository.nameWithOwner}}|{{.repository.name}}|{{.updatedAt}}{{\"\\n\"}}{{end}}'",
	})

	local sep = "|"
	local results_out = {}

	for _, item in ipairs(output) do
		local gh_pr_details = {}

		if item ~= "'" then
			for str in string.gmatch(item, "([^" .. sep .. "]+)") do
				stripped = string.gsub(str, "^'", "")
				table.insert(gh_pr_details, stripped)
			end
			table.insert(results_out, gh_pr_details)
		end
	end

	opts = opts or themes.get_dropdown({}) -- fix!!
	pickers
		.new(opts, {
			prompt_title = "Miles' Recent PRs",
			finder = finders.new_table({
				results = results_out,
				entry_maker = function(entry)
					return {
						value = "https://github.com/" .. entry[4] .. "/pull/" .. entry[1],
						display = "PR " .. entry[1] .. " - " .. entry[2] .. "[" .. entry[5] .. "] - " .. entry[3],
						ordinal = entry[4] .. " - " .. entry[2] .. " " .. entry[3],
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.api.nvim_put({ selection.value }, "", false, true)
				end)
				return true
			end,
		})
		:find()
end

_M.tf_state_show = function(opts)
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
end

return _M
