# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# diable weird copy/paste bug
# from https://github.com/ohmyzsh/ohmyzsh/issues/5569
DISABLE_MAGIC_FUNCTIONS=true

source $ZSH/oh-my-zsh.sh

#################################
#       GENERAL ALIASES         #
#################################
alias vim='nvim'
alias ll='lsd -la --color=never'
alias ls='lsd --color=never'
alias sl='ls'
alias c='clear'
alias vi='nvim'
alias j='jobs'
alias f='pushd'
alias b='popd'

#################################
#             GIT               #
#################################
alias gdiff='git diff'
alias gdif='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gpu='git push --set-upstream origin HEAD'
alias gp='git pull'
alias gco='git checkout'
alias gst='git status -sb'
alias gs='git status -sb'
alias gbr='git branch --sort=-committerdate'
alias gb='git branch --verbose --sort=-committerdate'
alias glog='git log --pretty=oneline'
alias glogp='git log --graph --abbrev-commit --decorate --date=relative --all'
alias gl='git log --decorate --oneline --all --graph --stat'

# stripe development
alias stripe_listen_webhook='stripe listen --events=invoice.upcoming,invoice.payment_succeeded,customer.source.updated,charge.refunded,customer.subscription.deleted --forward-to=localhost:4000/v1/hooks/stripe'

#################################
#           DOCKER              #
#################################
# docker stuff
alias dc='docker-compose'

# fixes issue when doing docker-compose build
# Follow link in https://github.com/google-github-actions/setup-gcloud/issues/128#issuecomment-663215962
export LD_LIBRARY_PATH=/usr/local/lib

#################################
# ELIXIR / ERLANG / KERL / ASDF #
#################################
alias chkfmt='docker-compose run --rm xgps mix format --check-formatted'
alias fmt='docker-compose run --rm xgps mix format'
alias riex='docker-compose run --rm iex'
alias dtest='docker-compose run --rm test'

export ERL_AFLAGS="-kernel shell_history enabled"
# export ERL_COMPILER_OPTIONS=bin_opt_info
export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac"

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

export PATH="$HOME/.mix/escripts:$PATH"

export PATH="$PATH:protoc-gen-elixir"

export PATH="$PATH:/usr/lib/elixir/1.10.4/bin"

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    source $HOME/.asdf/asdf.sh
fi

if [[ -f "$HOME/.asdf/completions/asdf.bash" ]]; then
    source $HOME/.asdf/completions/asdf.bash
fi

#################################
#           FZF                 #
#################################

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --multi'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#################################
#           BAT                 #
#################################
export BAT_THEME="Solarized (light)"

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

# command line copy/paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export EDITOR="/usr/bin/nvim"

if [[ -f "$HOME/Documents/scripts/z.sh" ]]; then
    source $HOME/Documents/scripts/z.sh
fi

# export LS_COLORS=$LS_COLORS:'di=0;35:'
