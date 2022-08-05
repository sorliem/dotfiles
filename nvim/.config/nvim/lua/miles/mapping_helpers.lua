local _M = {}

function _M.map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function _M.nmap(shortcut, command)
  _M.map('n', shortcut, command)
end

function _M.imap(shortcut, command)
  _M.map('i', shortcut, command)
end

return _M
