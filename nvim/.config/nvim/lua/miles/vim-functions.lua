-- someday i'll convert these to lua

vim.schedule(function()
	vim.cmd([[
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
  "nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  "nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
endif
]])

	vim.cmd([[
if has("persistent_undo")
    " set undodir=$HOME."/.undodir"
    let &undodir=$HOME."/.undodir"
    set undofile
endif
]])

	-- Jump to last edit position on opening file
	vim.cmd([[
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

	vim.cmd([[
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
]])

	vim.cmd([[
function! s:SaveQf(filename) abort
  let list = getqflist()

  for entry in list
    " Resolve each buffer to a filename, modify to take the absolute path
    let entry.filename = fnamemodify(bufname(entry.bufnr), ':p')
    " Remove bufnr to make sure Vim will deserialize the filename instead
    unlet entry.bufnr
  endfor

  let serialized_list = map(list, {_, entry -> json_encode(entry) })
  call writefile(serialized_list, a:filename)
endfunction

function! s:LoadQf(filename) abort
  if !filereadable(a:filename)
    echoerr "File not readable: " .. a:filename
    return
  endif

  let file_contents = readfile(a:filename)
  let quickfix_entries = map(file_contents, {_, line -> json_decode(line) })

  call setqflist(quickfix_entries)
  copen
endfunction

command! -nargs=1 -complete=file SaveQf call s:SaveQf(<f-args>)
command! -nargs=1 -complete=file LoadQf call s:LoadQf(<f-args>)
]])
end)
