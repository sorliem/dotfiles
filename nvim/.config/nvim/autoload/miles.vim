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

function! miles#update_daily()
    let latest_log = system("cd ~/gitroot/onxmaps/xgps && git log master -n 1 --oneline")
    let matches = []
    call substitute(latest_log, '(#\(\d\d\d\d\))', '\=add(matches, submatch(1))', 'g')
    call substitute(latest_log, '\([[:alnum:]]\{7}\)[[:alnum:]]\{2}', '\=add(matches, submatch(1))', 'g')
    let @z = matches[0] " pr number
    let @c = matches[1] " git shortsha

    execute ":edit variables_daily.tf"
    " update container_tag line with @c register contents
    norm! 85jvi""cp
    execute ":write"

    execute ":edit variables_staging.tf"
    " update container_tag line with @c register contents
    norm! 75jvi""cp
    execute ":write"

    execute ":Git"
    execute ":Git add ."
    execute ":Git commit -v"

    " paste commit template from @d register, fill in shortsha
    norm! "dpkddf,x"cp6j$v"cp

    "mark current line
    norm! ma

    "grab previous commit sha from diff
    execute ':g/^-\s\s/norm! yi"'

    " clear highlighting
    execute ':nohlsearch'

    " go back to mark, paste prev commit in compare link
    norm! 'af,vp

    " paste github link to PR, fill in PR number
    norm! 3k"gpviw"zp
endfunction

function! miles#update_production()
    " Update xgps variables_production.tf with latest commit on master

    let latest_log = system("cd ~/gitroot/onxmaps/xgps && git log master -n 1 --oneline")
    let matches = []
    call substitute(latest_log, '(#\(\d\d\d\d\))', '\=add(matches, submatch(1))', 'g')
    call substitute(latest_log, '\([[:alnum:]]\{7}\)[[:alnum:]]\{2}', '\=add(matches, submatch(1))', 'g')
    let @z = matches[0] " pr number
    let @c = matches[1] " git shortsha

    execute ":edit variables_production.tf"
    norm! 75jvi""cp
    execute ":write"

    execute ":Git"
    execute ":Git add ."
    execute ":Git commit -v"

    " paste commit template from @p register, fill in shortsha
    norm! "ppkddf,x"cp6j$v"cp

    "mark current line
    norm! ma

    "grab previous commit sha from diff
    execute ':g/^-\s\s/norm! yi"'

    " clear highlighting
    execute ':nohlsearch'

    " go back to mark, paste prev commit in compare link
    norm! 'af,vp

    " paste github link to PR, fill in PR number
    norm! 3k"gpviw"zp
endfunction
