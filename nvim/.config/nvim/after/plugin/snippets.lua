if vim.g.snippets ~= "luasnip" then
  return
end

local ls = require("luasnip")
local snippet = ls.s
local snippet_from_nodes = ls.sn
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local types = require("luasnip.util.types")

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

ls.config.set_config {
    history = false,
    updateevents = "TextChanged,TextChangedI",
    ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « CHOICE " } },
        hl_group = "GruvboxBlue"
      },
      unvisited = {
        hl_group = "GruvboxGreen"
      }
    },
  },
}

local all_snippets = {
    snippet("simple", t("wow, so simple")),
}

local javascript_snippets = {
    snippet("log", fmt("console.log('{}')", { i(1, "log") })),
}

local lua_snippets = {
    snippet({trig = "for", dscr = "for loop in lua"}, {
            t "for ",
            i(1, "k, v"),
            t " in ",
            i(2, "ipairs()"),
            t { " do", "  " },
            i(0),
            t { "", "" },
            t "end",
        }),
    snippet("req", fmt([[local {} = require("{}")]], {
        d(2, require_var, { 1 }),
        i(1),
    }))
}

local elixir_snippets = {
    snippet("ins", fmt('IO.inspect({}, label: "{}{}")', { i(1, "var"), rep(1), i(0) })),
    snippet("ins2", fmt('IO.inspect({}, label: "{}")', { i(1, "var"), i(2, "label") })),
    snippet("pins", fmt('|> IO.inspect(label: "{}")', { i(1, "label") })),
    snippet("iop", fmt('IO.puts("{}")', { i(1) })),
    snippet("mdoc", fmt('@moduledoc """\n{}\n"""', { i(1) })),
    snippet("fdoc", fmt('@doc """\n{}\n"""', { i(1) })),
    snippet("test", fmt('test "{}" do \n{}\nend', { i(1, "test_name"), i(2) })),
    snippet("itest", fmt('it "{}" do \n{}\nend', { i(1, "test_name"), i(2) })),
    snippet("assert", fmt('assert {} == {}', {i(1, "left"), i(2, "right")})),
    snippet("assert_recv", fmt('assert_receive {}', { i(1) })),
    snippet({trig = "mod", dscr = "Define an elixir module"}, fmt(
            [[
            defmodule {} do
              @moduledoc """
              """

              {}
            end
            ]],
            { i(1, "mod_name"), i(0) }
        )
    ),
    snippet({trig = "tmodeu", dscr = "Define a test module with ExUnit.Case loaded"}, fmt(
            [[
            defmodule {}Test do
              use ExUnit.Case

              setup do

              end

              test "{}" do
              end
            end
            ]],
            { i(1, "mod_under_test"), i(0, "first_test_name") }
        )
    ),
    snippet({trig = "tmodes", dscr = "Define a test module with ExSpec loaded"}, fmt(
            [[
            defmodule {}Test do
              use ExSpec

              setup do

              end

              it "should {}" do
                {}
              end
            end
            ]],
            { i(1, "mod_under_test"), i(2, "first_test_name"), i(0) }
        )
    ),
    snippet({trig = "expect", dscr = "Mox expect function"}, fmt(
            [[
            expect({}, {}, {}, fn {} ->
              {}
            end)
            ]],
            {
                i(1, "mod"),
                i(2, "fun"),
                i(3, "num_calls"),
                i(4, "fun_args"),
                i(0, "return_val")
            }
        )
    )
}

local go_snippets = {
    snippet("fmt", fmt('fmt.Printf("{}\n", {})', { i(1, "str"), i(2, "replacements") }))
}

ls.add_snippets("all", all_snippets)
ls.add_snippets("lua", lua_snippets)
ls.add_snippets("elixir", elixir_snippets)
ls.add_snippets("go", go_snippets)
ls.add_snippets("javascript", javascript_snippets)

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
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

-- add html snips to elixir templates
require("luasnip").filetype_extend("eelixir", {"html"})
