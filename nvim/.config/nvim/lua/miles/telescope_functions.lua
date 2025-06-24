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
local work_functions = require("miles.work-commands")

local _M = {}

local copy_to_default_register = function(prompt_bufnr)
	return function()
		-- Get the preview buffer
		local preview_bufnr = require("telescope.actions.state").get_current_picker(prompt_bufnr).previewer.state.bufnr
		if preview_bufnr and vim.api.nvim_buf_is_valid(preview_bufnr) then
			-- Get all lines from the preview buffer
			local content = table.concat(vim.api.nvim_buf_get_lines(preview_bufnr, 0, -1, false), "\n")
			-- Copy to default register
			vim.fn.setreg('"', content)
			print("Copied resource state to register")
		else
			print("Preview buffer not available")
		end
		actions.close(prompt_bufnr)
	end
end

_M.onx_live_grep = function(_)
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

			return vim.iter({
				args,
				{
					"--hidden",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
			})
				:flatten()
				:totable()
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Multi Grep",
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
						-- value = "JIRA https://onxmaps.atlassian.net/browse/" .. entry[1],
						value = entry[1],
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

_M.tf_state_show = function()
	local workspace = vim.fn.system("terraform workspace show"):gsub("\n", "")
	pickers
		.new({
			prompt_title = "Terraform state show",
			results_title = string.format("Resources (%s)", workspace),
			finder = finders.new_oneshot_job({ "terraform", "state", "list" }, { cwd = vim.uv.cwd() }),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry, status)
					return require("telescope.previewers.utils").job_maker(
						{ "terraform", "state", "show", entry.value, "-no-color" },
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
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(copy_to_default_register(prompt_bufnr))
				return true
			end,
		}, {})
		:find()
end

_M.view_secrets = function(opts)
	local project = nil
	if opts.project == nil then
		project = utils.get_os_command_output({ "gcloud", "config", "get", "project" })[1]
	else
		project = opts.project
	end

	local show_actual_value = false

	pickers
		.new({
			prompt_title = string.format("View secrets (%s)", project),
			results_title = string.format("Secrets (%s)", project),
			finder = finders.new_oneshot_job(
				{ "gcloud", "secrets", "list", "--format=value(name)", string.format("--project=%s", project) },
				{ cwd = vim.uv.cwd() }
			),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry, _)
					if not show_actual_value then
						vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
							"SECRET HIDDEN, Press <C-s> to toggle reveal",
						})
						return
					end

					return require("telescope.previewers.utils").job_maker({
						"gcloud",
						"secrets",
						"versions",
						"access",
						"latest",
						string.format("--secret=%s", entry.value),
						string.format("--project=%s", project),
					}, self.state.bufnr)
				end,
			}),
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<C-s>", function()
					show_actual_value = not show_actual_value
					local current_picker = action_state.get_current_picker(prompt_bufnr)
					current_picker:refresh_previewer()
				end)

				actions.select_default:replace(copy_to_default_register(prompt_bufnr))
				return true
			end,
		}, {})
		:find()
end

local gcloud_explore = function(opts)
	local show_actual_value = opts.hide_value
	local fmt_cmd = vim.split(string.format("%s --project=%s", opts.list_cmd, opts.project), " ")

	pickers
		.new({
			prompt_title = string.format("%s (%s)", opts.prompt_title, opts.project),
			results_title = "Results",
			finder = finders.new_oneshot_job(fmt_cmd, { cwd = vim.uv.cwd() }),
			sorter = sorters.get_fuzzy_file(),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry, _)
					if not show_actual_value then
						vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
							"VALUE HIDDEN, Press <C-s> to toggle reveal",
						})
						return
					end
					local fmt_show_cmd = string.format(opts.show_cmd, entry.value, opts.project)
					local fmt_show_cmd_split = vim.split(
						string.format("%s --format=%s --project=%s", fmt_show_cmd, opts.format, opts.project),
						" "
					)

					return require("telescope.previewers.utils").job_maker(fmt_show_cmd_split, self.state.bufnr, {
						callback = function(bufnr, content)
							if content ~= nil then
								require("telescope.previewers.utils").regex_highlighter(bufnr, opts.format)
							end
						end,
					})
				end,
			}),
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<C-s>", function()
					show_actual_value = not show_actual_value
					local current_picker = action_state.get_current_picker(prompt_bufnr)
					current_picker:refresh_previewer()
				end)

				actions.select_default:replace(copy_to_default_register(prompt_bufnr))
				return true
			end,
		}, {})
		:find()
end

local gcloud_mappings = {
	{
		cmd = "GcloudServiceExtensions",
		prompt_title = "Service extensions",
		list_cmd = "gcloud service-extensions lb-traffic-extensions list --format=value(name) --location=global",
		show_cmd = "gcloud service-extensions lb-traffic-extensions describe %s --location=global",
	},
	{
		cmd = "GcloudRunJobs",
		prompt_title = "Cloud Run Jobs in us-central1",
		list_cmd = "gcloud run jobs list --format=value(name)",
		show_cmd = "gcloud run jobs describe %s --region=us-central1",
	},
	{
		cmd = "GcloudSqlInstances",
		prompt_title = "Sql Instances",
		list_cmd = "gcloud sql instances list --format=value(name)",
		show_cmd = "gcloud sql instances describe %s",
	},
	{
		cmd = "GcloudManagedSecrets",
		prompt_title = "Managed Secrets",
		list_cmd = "gcloud secrets list --format=value(name)",
		show_cmd = "gcloud secrets versions access latest --secret=%s",
		gcloud_display_format = "", -- empty string reveals secret
		show_actual_value = false, -- don't show actual secret value by default
	},
}

vim.schedule(function()
	for _, value in pairs(gcloud_mappings) do
		local hide_value = (value.show_actual_value == true or value.show_actual_value == nil) or false
		local format_value = (value.gcloud_display_format ~= nil and value.gcloud_display_format) or "yaml"

		vim.api.nvim_create_user_command(value.cmd, function(opts)
			local project = nil
			if opts.args ~= "" then
				project = opts.args
			else
				project = utils.get_os_command_output({ "gcloud", "config", "get", "project" })[1]
			end
			gcloud_explore({
				prompt_title = value.prompt_title,
				list_cmd = value.list_cmd,
				show_cmd = value.show_cmd,
				hide_value = hide_value,
				format = format_value,
				project = project,
			})
		end, {
			nargs = "?",
			desc = "Explore " .. value.prompt_title,
			complete = function()
				return work_functions.gcloud_projects()
			end,
		})
	end
end)

return _M
