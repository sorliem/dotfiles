local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
MilesDevGroup = augroup("Miles", {})
YankGroup = augroup("YankGroup", {})
WhiteSpaceGroup = augroup("WhiteSpaceGroup", {})
PackerGroup = augroup("PackerGroup", {})

-- autocmd("BufWritePre", {
-- 	group = WhiteSpaceGroup,
-- 	pattern = "*",
-- 	command = "%s/\\s\\+$//e",
-- })

-- autocmd("WinLeave", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.opt.cursorline = false
-- 		vim.opt.cursorcolumn = false
-- 	end,
-- })

-- autocmd("WinEnter", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.opt.cursorline = true
-- 		vim.opt.cursorcolumn = true
-- 	end,
-- })
--

autocmd("TextYankPost", {
	group = YankGroup,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
	end,
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = MilesDevGroup,
	pattern = { "*.ex", ".exs" },
	command = "set syntax=elixir",
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = MilesDevGroup,
	pattern = "*.eex",
	command = "set syntax=eelixir",
})

autocmd("FileType", {
	group = MilesDevGroup,
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.wrap = true
	end,
})

autocmd("FileType", {
	group = MilesDevGroup,
	pattern = { "vimwiki" },
	callback = function()
		vim.opt_local.spell = true
		-- vim.opt.listchars:remove('eol')
	end,
})

-- vim.api.nvim_create_autocmd(
-- 	{ "FocusLost", "ModeChanged", "TextChanged", "BufEnter" },
-- 	{ desc = "autosave", pattern = "*", command = "silent! update" }
-- )

vim.api.nvim_create_autocmd({ "VimResized" }, {
	desc = "resize splits if window got resized",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
		vim.opt_local.scrolloff = 0
		vim.bo.filetype = "terminal"
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ctx)
		-- local root = vim.fs.root(ctx.buf, { ".git", "Makefile" })
		-- if root then
		-- 	vim.uv.chdir(root)
		-- end
	end,
})

local attach_to_buffer = function(output_bufnr, pattern, command)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("miles-autorun", { clear = true }),
		pattern = pattern,
		callback = function()
			local append_data = function(_, data)
				if data then
					vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
				end
			end

			vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "AutoRun output:" })
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = append_data,
				on_stderr = append_data,
			})
		end,
	})
end

local get_buf_names = function()
	local bufs = {}

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local bufnr = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(bufnr)

		if name == "" then
			name = "[no name]"
		end

		local str = "bufnr " .. tostring(bufnr) .. " is " .. name
		table.insert(bufs, str)
	end

	return bufs
end

vim.api.nvim_create_user_command("AutoRun", function()
	local bufs = get_buf_names()
	local prompt = table.concat(bufs, "\n") .. "\nq to quit\nBufnr: "

	local bufnr = vim.fn.input(prompt)

	if bufnr == "q" then
		return
	end

	local pattern = vim.fn.input("Pattern: ")
	local command = vim.split(vim.fn.input("Command: "), " ")
	attach_to_buffer(tonumber(bufnr), pattern, command)
end, {})

-- Highlight the trailing space with DiffDelete highight group
-- vim.cmd([[
-- augroup TrailingSpace
--   au!
--   au VimEnter,WinEnter * highlight link TrailingSpaces DiffDelete
--   au VimEnter,WinEnter * match TrailingSpaces /\s\+$/
-- augroup END
-- ]])
