vim.fn.matchadd("Added", "will be created")
vim.fn.matchadd("Removed", "will be destroyed")

vim.cmd([[
highlight TFCreatedGroup ctermbg=green guibg=green
let m = matchadd("TFCreatedGroup", "will be created")
let m = matchadd("TFCreatedGroup", "\v\d+ to add")

highlight TFModifiedGroup ctermbg=yellow guibg=yellow
let m = matchadd("TFModifiedGroup", "will be modified")
let m = matchadd("TFModifiedGroup", "\v\d+ to change")

highlight TFDestroyedGroup ctermbg=red guibg=red
let m = matchadd("TFDestroyedGroup", "will be destroyed")
let m = matchadd("TFDestroyedGroup", "\v\d+ to destroy")
]])
