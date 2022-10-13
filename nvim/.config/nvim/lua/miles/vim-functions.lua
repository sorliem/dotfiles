-- someday i'll convert these to lua

vim.cmd [[
if executable('rg')
	let g:rg_derive_root='true'
endif
]]

vim.cmd [[
if executable('rg')
   command! -bang -nargs=* R
     \ call fzf#vim#grep(
     \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
     \   fzf#vim#with_preview(), <bang>0)
endif
]]

vim.cmd [[
" vim & tmux navigation
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
]]

vim.cmd [[
if exists('$TMUX')
    function! RunElixirTest()
        let cmd = "tmux send-keys -t xgps:xgps-test.1 'dtest " . expand('%:') . "' C-m"
        echo "Running test " . expand('%:')
        call system(cmd)
    endfunction

    function! RunAllTests()
        let cmd = "tmux send-keys -t xgps:xgps-3.1 'dtest' C-m"
        echo "Running all tests"
        call system(cmd)
    endfunction
endif
]]

vim.cmd [[
if has("persistent_undo")
    " set undodir=$HOME."/.undodir"
    let &undodir=$HOME."/.undodir"
    set undofile
endif
]]

vim.cmd [[
function! SaveAndExec()
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :luafile %
  endif

  return
endfunction
]]

vim.cmd [[
function! RunFormatter()
    let cmd = "docker-compose run --rm xgps mix format"
    echo "Running project wide formatter for xgps"
    call system(cmd)
endfunction
]]
