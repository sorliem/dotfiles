local _M = {}

local telescope_functions = require("miles.telescope_functions")

_M.git_sha = function(_, _, user_arg)
	local diff_direction

	if user_arg == "add" then
		diff_direction = "+"
	else
		diff_direction = "-"
	end

	local raw_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for _, line in ipairs(raw_lines) do
		local _, _, prev_git_sha = string.find(line, "^" .. diff_direction .. '%s+container_tag%s+=%s"(.*)"')
		if prev_git_sha then
			return prev_git_sha
		end
	end

	return "no_git_sha_found"
end

_M.jira_ticket_number = function(_, _, _)
	-- method 1: get from branch
	local branch = vim.fn.system("git branch | grep '*'")
	if branch ~= "" then
		-- matches author/FOO-300-my-feature-branch -> FOO-300
		local number = string.match(branch, "^.*/(%w+-%d+)-.*$")
		if number then
			return number
		end

		-- matches author/300-my-feature-branch -> 300
		local number2 = string.match(branch, "^.*/(%d+)-.*$")
		if number2 then
			return number2
		end

		local number3 = string.match(branch, "^.*-(%d+)$")
		if number3 then
			return number3
		end
	end

	-- method 2: get from lines in file
	local raw_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for _, line in ipairs(raw_lines) do
		-- looking for a ticket number in the branch name which appears in the git
		-- diff, eg author/FOO-410-my-feature, pulls out '410'
		local number = string.match(line, "^.*-(%d+)-.*$")
		if number then
			return number
		end
	end

	return nil
end

return _M
