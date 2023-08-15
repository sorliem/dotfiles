export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

# source $ZSH/oh-my-zsh.sh


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#################################
#       GENERAL ALIASES         #
#################################
alias vim='nvim'
alias vm='nvim'
alias im='nvim'
alias vmi='nvim'
alias ivm='nvim'
alias v='nvim'
# alias ll='lsd -la --color=never'
# alias ls='lsd --color=never'
alias sl='ls'
alias ls='lsd'
alias c='clear'
alias vi='nvim'
alias j='jobs'
alias f='pushd'
alias b='popd'
alias lua='lua5.3'
alias ll='ls -alh'

#################################
#             GIT               #
#################################
alias gdiff='git diff'
alias gdif='git diff'
alias gdm='git diff master..HEAD'
alias ga='git add'
alias gc='git commit -m'
alias gpu='git push --set-upstream origin HEAD'
alias gp='git pull'
alias gco='git checkout'
alias gcom='git checkout master'
alias gst='git status -sb'
alias gs='git status -sb'
alias gbr='git branch --sort=-committerdate'
alias gb='git branch --verbose --sort=-committerdate'
alias glog='git log --pretty=oneline'
alias glogp='git log --graph --abbrev-commit --decorate --date=relative --all'
alias gl='git log --decorate --oneline --all --graph --stat'
alias gl1='git log -n 1'
alias gw='git worktree'
alias shortsha='git rev-parse --short=7 HEAD'

alias dc='docker compose'


function delete-branches() {
  git branch |
    grep --invert-match '\*' |
    grep --invert-match 'master' |
    grep --invert-match 'daily' |
    grep --invert-match 'staging' |
    cut -c 3- |
    fzf --multi --bind up:preview-up,down:preview-down --preview="git log {} --" |
    xargs --no-run-if-empty git branch --delete
}


#################################
#           TERRAFORM           #
#################################
alias tf='terraform'
alias tfmt="terraform fmt -recursive"
alias tfapply="terraform apply"
alias tfdocs="terraform-docs markdown ./ --hide requirements --output-mode merge --output-file README.md"
alias tfgit="terraform-docs markdown ./ --recursive --hide requirements --output-mode merge --output-file README.md && terraform fmt -recursive && git add --all"
alias {tfinit,tfi}="echo \"removing .terraform dir\n\"; rm -rf .terraform*; terraform init --upgrade"
alias tfws="terraform workspace select"
alias tfplan="terraform plan"
alias tfproviders="terraform providers"
alias tfrefresh="terraform refresh"
alias tfupgrade="terraform init --upgrade"
alias tfvalidate="terraform validate"
alias tfworkspace="terraform workspace select"
alias switch_local_modules="git grep -l 'terraform-modules.git' | grep -v README | xargs sed -i'' 's/git@github.com:onXmaps\/terraform-modules.git/\/Users\/miles.sorlie\/gitroot\/onxmaps\/terraform-modules/g'"

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export TF_CLI_ARGS_plan="-parallelism=100"
export TF_CLI_ARGS_apply="-parallelism=100"

export PATH=$PATH:$HOME/.tfenv/bin


# fixes issue when doing docker-compose build
# Follow link in https://github.com/google-github-actions/setup-gcloud/issues/128#issuecomment-663215962
export LD_LIBRARY_PATH=/usr/local/lib


export ERL_AFLAGS="-kernel shell_history enabled"
# export ERL_COMPILER_OPTIONS=bin_opt_info
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac -with-ssl=/usr/local/ssl"
export KERL_BUILD_DOCS="yes"

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

export PATH="$HOME/.mix/escripts:$PATH"

export PATH="$PATH:protoc-gen-elixir"

export PATH="$PATH:/usr/lib/elixir/1.11.4/bin"

export PATH="$PATH:/usr/local/mysql/bin"

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    source $HOME/.asdf/asdf.sh
fi

if [[ -f "$HOME/.asdf/completions/asdf.bash" ]]; then
    source $HOME/.asdf/completions/asdf.bash
fi

#################################
#           FZF                 #
#################################

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --multi --bind up:preview-up,down:preview-down'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#################################
#           BAT                 #
#################################
# export BAT_THEME="Solarized (light)"
export BAT_THEME="Nord"

#################################
#           GOLANG              #
#################################
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export GO111MODULE=on

#################################
#           RUST                #
#################################
export PATH="$HOME/.cargo/bin:$PATH"

#################################
#           GPG                 #
#################################
export GPG_TTY=$(tty)

#################################
#     NODE VERSION MANAGER      #
#################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#################################
#           MISC                #
#################################
export PATH="$HOME/.local/bin:$PATH"
export DB_HOSTNAME=localhost
export PATH="$HOME/bin:$PATH"
export DOTFILES=$HOME/dotfiles

export PATH="$HOME/.tools/lua-language-server/bin/Linux:$PATH"

export PATH="$HOME/.tfenv/bin:$PATH"

# command line copy/paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export EDITOR="/usr/local/bin/nvim"

if [[ -f "$HOME/gitroot/src/z/z.sh" ]]; then
  source $HOME/gitroot/src/z/z.sh
fi

bindkey -s ^f "tmux-sessionizer\n"

# Tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"
eval "$(tmuxifier init -)"

# export LS_COLORS=$LS_COLORS:'di=0;35:'

# don't auto-cd into a dir by typing its name
unsetopt AUTO_CD

# share history between sessions
# setopt share_history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.work_zshrc
# source ~/gitroot/src/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# source ~/gitroot/src/powerlevel10k/config/p10k-robbyrussell.zsh
# source ~/gitroot/src/powerlevel10k/config/p10k-classic.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k_work.zsh ]] || source ~/.p10k_work.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/miles.sorlie/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/miles.sorlie/.local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/miles.sorlie/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/miles.sorlie/.local/google-cloud-sdk/completion.zsh.inc'; fi
