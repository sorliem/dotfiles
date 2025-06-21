return {
	{
		"AndrewRadev/switch.vim",
		keys = {
			{ "gs", nil, { "n", "v" }, desc = "Switch" },
		},
		config = function()
			local fk = [=[\<\(\l\)\(\l\+\(\u\l\+\)\+\)\>]=]
			local sk = [=[\<\(\u\l\+\)\(\u\l\+\)\+\>]=]
			local tk = [=[\<\(\l\+\)\(_\l\+\)\+\>]=]
			local fok = [=[\<\(\u\+\)\(_\u\+\)\+\>]=]
			local folk = [=[\<\(\l\+\)\(\-\l\+\)\+\>]=]
			local fik = [=[\<\(\l\+\)\(\.\l\+\)\+\>]=]
			vim.g["switch_custom_definitions"] = {
				vim.fn["switch#NormalizedCaseWords"]({
					"sunday",
					"monday",
					"tuesday",
					"wednesday",
					"thursday",
					"friday",
					"saturday",
				}),
				vim.fn["switch#NormalizedCase"]({ "yes", "no" }),
				vim.fn["switch#NormalizedCase"]({ "on", "off" }),
				vim.fn["switch#NormalizedCase"]({ "left", "right" }),
				vim.fn["switch#NormalizedCase"]({ "up", "down" }),
				vim.fn["switch#NormalizedCase"]({ "enable", "disable" }),
				vim.fn["switch#NormalizedCase"]({ "Always", "Never" }),
				vim.fn["switch#NormalizedCase"]({ "debug", "info", "warning", "error", "critical" }),
				{ "==", "!=", "~=" },
				{
					[fk] = [=[\=toupper(submatch(1)) . submatch(2)]=],
					[sk] = [=[\=tolower(substitute(submatch(0), '\(\l\)\(\u\)', '\1_\2', 'g'))]=],
					[tk] = [=[\U\0]=],
					[fok] = [=[\=tolower(substitute(submatch(0), '_', '-', 'g'))]=],
					[folk] = [=[\=substitute(submatch(0), '-', '.', 'g')]=],
					[fik] = [=[\=substitute(submatch(0), '\.\(\l\)', '\u\1', 'g')]=],
				},
			}
		end,
		init = function()
			local custom_switches = vim.api.nvim_create_augroup("CustomSwitches", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = custom_switches,
				pattern = { "gitrebase" },
				callback = function()
					vim.b["switch_custom_definitions"] = {
						{ "pick", "reword", "edit", "squash", "fixup", "exec", "drop" },
					}
				end,
			})
			-- (un)check markdown buxes
			vim.api.nvim_create_autocmd("FileType", {
				group = custom_switches,
				pattern = { "markdown" },
				callback = function()
					local fk = [=[\v^(\s*[*+-] )?\[ \]]=]
					local sk = [=[\v^(\s*[*+-] )?\[x\]]=]
					local tk = [=[\v^(\s*[*+-] )?\[-\]]=]
					local fok = [=[\v^(\s*\d+\. )?\[ \]]=]
					local fik = [=[\v^(\s*\d+\. )?\[x\]]=]
					local sik = [=[\v^(\s*\d+\. )?\[-\]]=]
					vim.b["switch_custom_definitions"] = {
						{
							[fk] = [=[\1[x]]=],
							[sk] = [=[\1[-]]=],
							[tk] = [=[\1[ ]]=],
						},
						{
							[fok] = [=[\1[x]]=],
							[fik] = [=[\1[-]]=],
							[sik] = [=[\1[ ]]=],
						},
					}
				end,
			})
		end,
	},
}
