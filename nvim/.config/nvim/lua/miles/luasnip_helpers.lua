local _M = {}

local telescope_functions = require("miles.telescope_functions")

_M.git_sha = function(_, _, _)
	local raw_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for _, line in ipairs(raw_lines) do
		local _, _, git_sha = string.find(line, '^+%s+container_tag%s+=%s"(.*)"')
		if git_sha then
			return git_sha
		end
	end

	return "no_git_sha_found"
end

_M.prev_git_sha = function(_, _, _)
	local raw_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for _, line in ipairs(raw_lines) do
		local _, _, prev_git_sha = string.find(line, '^-%s+container_tag%s+=%s"(.*)"')
		if prev_git_sha then
			print("MATCH!: " .. prev_git_sha)
			return prev_git_sha
		end
	end

	return "no_prev_git_sha_found"
end

_M.get_wiki_file_name_without_extension = function(_, _, _)
	local filename = vim.fn.expand("%:t")
	return filename:gsub("(.wiki)$", "")
end

_M.jira_ticket_number = function(_, _, _)
	local raw_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for _, line in ipairs(raw_lines) do
		-- looking for a ticket number in the branch name which appears in the git
		-- diff, eg author/FOO-410-my-feature, pulls out '410'
		local number = string.match(line, "^.*-(%d+)-.*$")
		if number then
			return number
		end
	end

	print("could not get jira ticket number from lines in buffer")

	local branch = vim.fn.system("git branch | grep '*'")
	print("branch name = ", branch)
	if branch ~= "" then
		-- matches author/FOO-300-my-feature-branch -> 300
		local number = string.match(branch, "^.*-(%d+)-.*$")
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

	local filename = vim.fn.expand("%:t")
	local number = string.match(filename, "^.*-(%d+)%s.*$")
	if number then
		print("got jira number from filename")
		return number
	end

	return nil
end

return _M
