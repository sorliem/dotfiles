-- require("luasnip.loaders.from_snipmate").load({ paths = {"./snippets"}})

if vim.g.snippets ~= "luasnip" then
  print "NOT SETTING UP LUASNIPS"
  return
end

local function write_to_file(content)
    local file = io.open("/tmp/snipoutput", "a")
    file:write(content .. "\n")
    file:close()
end


local ls = require("luasnip")
local snippet = ls.s
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
}

local all_snippets = {
    snippet("simple", t("wow, you were right!")),
    snippet("date", {
      f(function()
        return string.format(string.gsub(vim.bo.commentstring, "%%s", " %%s"), os.date())
      end, {}),
    }),
}

local lua_snippets = {
    snippet("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1)})),
    snippet("for", {
            t "for ",
            i(1, "k, v"),
            t " in ",
            i(2, "ipairs()"),
            t { " do", "  " },
            i(0),
            t { "", "" },
            t "end",
        }),
}

local elixir_snippets = {
    snippet("ins", fmt('IO.inspect({}, label: "{}")', { i(1, "var"), i(2, "label") })),
    snippet("pins", fmt('|> IO.inspect(label: "{}")', { i(1, "label") })),
    snippet("mdoc", fmt('@moduledoc """\n{}\n"""', { i(1) })),
    snippet("test", fmt('test "{}" do \n{}\nend', { i(1, "test_name"), i(2) })),
    snippet("itest", fmt('it "{}" do \n{}\nend', { i(1, "test_name"), i(2) })),
}

local go_snippets = {

}

ls.add_snippets("all", all_snippets)
ls.add_snippets("lua", lua_snippets)
ls.add_snippets("elixir", elixir_snippets)
ls.add_snippets("go", go_snippets)

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    write_to_file("\n=========================")
    -- print("IN EXPAND FUNCTION")
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    -- else
        -- print("NOT JUMPABLE")
    end
end, { silent = true })

-- <c-j> is my jump backwards key
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes
vim.keymap.set("i", "<c-j>", function()
    if ls.choice_active() then
        ls.change_choice()
    end
end)

-- reload snippets easy
vim.keymap.set("n", "<leader>rs", "<cmd>source ~/.config/nvim/lua/miles/snippets.lua<CR>")
