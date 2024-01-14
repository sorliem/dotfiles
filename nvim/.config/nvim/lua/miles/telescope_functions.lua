local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local themes = require("telescope.themes")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local utils = require("telescope.utils")

local _M = {}

_M.onx_live_grep = function(opts)
	local ft = vim.fn.input("File type(s) to search onx files for (comma-delimited): ")

	local delimiter = ","
	local additional_args_list = {}
	local startIndex = 1

	-- gross string split, thanks to chatgpt
	while true do
		local endIndex = string.find(ft, delimiter, startIndex)

		if endIndex == nil then
			table.insert(additional_args_list, "--type")
			table.insert(additional_args_list, string.sub(ft, startIndex))
			break
		end

		table.insert(additional_args_list, "--type")
		table.insert(additional_args_list, string.sub(ft, startIndex, endIndex - 1))
		startIndex = endIndex + 1
	end

	table.insert(additional_args_list, { "--hidden", "--ignore-case" })

	require("telescope.builtin").live_grep({
		cwd = "~/gitroot/onxmaps",
		additional_args = additional_args_list,
		prompt_title = "Live Grep all [" .. ft .. "] OnX Files",
	})
end

-- our picker function: colors
_M.jira_tickets = function(opts)
	-- local output2 = utils.get_os_command_output({
	-- 	"jira",
	-- 	"issue",
	-- 	"list",
	-- 	"-q",
	-- 	'project in ("GD", "SRE") AND assignee = "Miles Sorlie" AND status in ("In Progress", "To Do", "In Review", "Backlog")',
	-- 	"--plain",
	-- 	"--columns",
	-- 	"key,status,summary",
	-- })
	-- print("output2: ", vim.inspect(output2))

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
return _M
