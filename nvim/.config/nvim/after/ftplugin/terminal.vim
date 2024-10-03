" terraform plan highlight groups
highlight TFCreatedGroup ctermbg=green guibg=green guifg=white
call matchadd("TFCreatedGroup", 'will be created')
call matchadd("TFCreatedGroup", '[1-9]\d* to add')

highlight TFModifiedGroup guifg=#ffffff guibg=#e89153
call matchadd("TFModifiedGroup", 'will be modified')
call matchadd("TFModifiedGroup", 'will be updated in-place')
call matchadd("TFModifiedGroup", '[1-9]\d* to change')

" highlight TFDestroyGroup guifg=#eb6f92 guibg=#4b3148
highlight TFDestroyGroup guifg=#ffffff guibg=#eb6f92
call matchadd("TFDestroyGroup", 'will be destroyed')
call matchadd("TFDestroyGroup", '[1-9]\d* to destroy')

highlight TFReadGroup cterm=reverse gui=reverse guifg=#83a598
call matchadd("TFReadGroup", 'will be read during apply')

highlight TFCompleteGroup cterm=reverse gui=reverse guifg=#13a598
call matchadd("TFCompleteGroup", 'complete')

