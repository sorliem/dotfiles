require("miles.mapping_helpers")
require("miles.telescope")
require("miles.lsp")
require("miles.lualine")
require("miles.completion")
require("miles.snippets")
require("miles.treesitter")

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
