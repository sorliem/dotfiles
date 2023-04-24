local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local themes = require("telescope.themes")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local utils = require("telescope.utils")

local _M = {}

_M.onx_live_grep = function(opts)
	local ft = vim.fn.input("File type to search onx files for (see rg --type-list): ")

	require("telescope.builtin").live_grep({
		cwd = "~/gitroot/onxmaps",
		type_filter = ft,
		prompt_title = "Live Grep all [" .. ft .. "] OnX Files",
	})
end

-- our picker function: colors
_M.jira_tickets = function(opts)
	local output = utils.get_os_command_output({
		"jira",
		"issue",
		"list",
		"-q",
		'assignee = "miles.sorlie@onxmaps.com" AND status in ("In Progress", "To Do", "In Review", "Backlog")',
		"--plain",
		"--columns",
		"key,status,summary",
	})

	table.remove(output, 1) -- remove CSV header

	local results_out = {}

	for _, item in ipairs(output) do
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
