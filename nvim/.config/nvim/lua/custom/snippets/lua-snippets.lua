require("luasnip.session.snippet_collection").clear_snippets("lua")

print("in lua-snippets.lua")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local snippet_from_nodes = ls.sn
local fmt = require("luasnip.extras.fmt").fmt

local require_var = function(args, _)
	local text = args[1][1] or ""
	local split = vim.split(text, ".", { plain = true })

	local options = {}
	for len = 0, #split - 1 do
		table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
	end

	return snippet_from_nodes(nil, {
		c(1, options),
	})
end

ls.add_snippets("lua", {
	s({ trig = "for", dscr = "for loop in lua" }, {
		t("for "),
		i(1, "k, v"),
		t(" in "),
		i(2, "ipairs()"),
		t({ " do", "  " }),
		i(0),
		t({ "", "" }),
		t("end"),
	}),
	s(
		"req",
		fmt([[local {} = require("{}")]], {
			d(2, require_var, { 1 }),
			i(1),
		})
	),
	s(
		{ trig = "ins", desc = "inspect vim object in lua" },
		fmt([[print("{} = " .. vim.inspect({}{}))]], {
			i(1, "label"),
			rep(1),
			i(0),
		})
	),
	s(
		{ trig = "insx", desc = "inspect vim object in lua" },
		fmt([[ngx.log(ngx.INFO, "{} = ", {}{})]], {
			i(1, "label"),
			rep(1),
			i(0),
		})
	),
})
