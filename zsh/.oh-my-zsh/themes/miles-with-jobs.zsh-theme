job_count() {
    JOB_COUNT=`jobs | wc -l`

    if [ $JOB_COUNT != 0 ]
    then
        echo "(j""$JOB_COUNT"")"
    fi
}

PROMPT='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'
# PROMPT+=' $(job_count)'
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%}$(job_count) $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
