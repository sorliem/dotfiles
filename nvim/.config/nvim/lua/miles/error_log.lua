local logfile = vim.fn.stdpath("state") .. "/errors.log"
local max_bytes = 5 * 1024 * 1024 -- rotate at 5 MB, keep one .old copy (max ~10 MB on disk)

local stat = vim.uv.fs_stat(logfile)
if stat and stat.size > max_bytes then
	os.rename(logfile, logfile .. ".old")
end

local function append(tag, text)
	local f = io.open(logfile, "a")
	if not f then
		return
	end
	f:write(string.format("[%s] [%s] %s\n", os.date("%Y-%m-%d %H:%M:%S"), tag, text))
	f:close()
end

append("session", "started pid=" .. vim.fn.getpid() .. " argv=" .. table.concat(vim.v.argv, " "))

local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
	append("notify", string.format("level=%s %s", tostring(level), tostring(msg)))
	return orig_notify(msg, level, opts)
end

local function wrap_with_trace(fn_name, orig)
	return function(fn, ...)
		local wrapped = function(...)
			local ok, err = xpcall(fn, debug.traceback, ...)
			if not ok then
				append("lua-error", fn_name .. ": " .. tostring(err))
				error(err)
			end
		end
		return orig(wrapped, ...)
	end
end

vim.schedule = wrap_with_trace("schedule", vim.schedule)
vim.defer_fn = wrap_with_trace("defer_fn", vim.defer_fn)

local orig_create_autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd = function(event, opts)
	if type(opts) == "table" and type(opts.callback) == "function" then
		local orig_cb = opts.callback
		opts.callback = function(...)
			local ok, err = xpcall(orig_cb, debug.traceback, ...)
			if not ok then
				append(
					"autocmd-error",
					string.format(
						"event=%s group=%s pattern=%s err=%s",
						vim.inspect(event),
						tostring(opts.group),
						tostring(opts.pattern),
						tostring(err)
					)
				)
				error(err)
			end
			return ok and err or nil
		end
	end
	return orig_create_autocmd(event, opts)
end

local last_len = 0
local timer = vim.uv.new_timer()
timer:start(
	50,
	250,
	vim.schedule_wrap(function()
		local ok, res = pcall(vim.api.nvim_exec2, "messages", { output = true })
		if not ok or not res or not res.output then
			return
		end
		local output = res.output
		if #output > last_len then
			append("messages+", output:sub(last_len + 1))
			last_len = #output
		elseif #output < last_len then
			last_len = #output
		end
	end)
)

vim.api.nvim_create_user_command("ErrorLog", function()
	vim.cmd("tabnew " .. vim.fn.fnameescape(logfile))
end, {})
