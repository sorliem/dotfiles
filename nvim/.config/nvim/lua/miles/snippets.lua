local M = {}

local ls = require("luasnip")

M.reload_snippets = function()
  ls.cleanup()
  vim.cmd("source ~/.config/nvim/after/plugin/snippets.lua")
  print("dumped and reloaded snippets")
end

return M
