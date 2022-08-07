vim.cmd[[
autocmd BufWritePre * :call TrimWhitespace()

" only have cursorline set on active window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

augroup miles_highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=250}
augroup END

augroup miles_elixir
    autocmd!
    autocmd BufNewFile,BufRead *.ex,*.exs set syntax=elixir
    autocmd BufNewFile,BufRead *.eex set syntax=eelixir
augroup END

augroup miles_git
  autocmd!
  autocmd FileType gitcommit setlocal wrap
  autocmd FileType gitcommit setlocal spell
  autocmd BufWritePre gitcommit :call CapitalizeFirstCharacter()
augroup END

augroup miles_markdown
  autocmd!
  autocmd FileType markdown setlocal wrap
  autocmd FileType markdown setlocal spell
augroup END
]]
