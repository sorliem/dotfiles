if !exists('*miles#save_and_exec')
  function! miles#save_and_exec() abort
    if &filetype == 'vim'
      :silent! write
      :source %
    elseif &filetype == 'lua'
      :silent! write
      :luafile %
    endif

    return
  endfunction
endif

if !exists('*miles#run_formatter')
    function! miles#run_formatter()
        let cmd = "docker-compose run --rm xgps mix format"
        echo "Running project wide formatter for xgps"
        call system(cmd)
    endfunction
endif
