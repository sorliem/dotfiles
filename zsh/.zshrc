# export ZSH="$HOME/.oh-my-zsih"
#
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zsh-fzf-history-search
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

autoload -Uz compinit
compinit

# ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# plugins=(git)

# source $ZSH/oh-my-zsh.sh


# emacs style navigation
bindkey -e


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
alias ls='lsd --color=never'
alias c='clear'
alias vi='nvim'
alias j='jobs'
alias f='pushd'
alias b='popd'
alias lua='lua5.3'
alias ll='ls -alh --color=never'

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
alias lg=lazygit

alias dc='docker compose'

# [g]it[h]ub [o]pen
alias gho='basename $(pwd) | xargs -I {} open https://github.com/onXmaps/{}'


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
alias tf='tofu'
alias tfws="tofu workspace select"
alias tfproviders="tofu providers"
alias tfwl="tofu workspace list"

function tfdocs () {
  if [ ! -d modules/ ]; then
    terraform-docs markdown ./
  else
    terraform-docs markdown ./ --recursive
  fi
}

# select multiple resources to show with fzf
function tfshow () {
  tf state list |\
  fzf --height=70% --header "[TF-WORKSPACE: $(tofu workspace show)] [REPO: $(basename $(pwd))]" |\
  sed 's/"/\\"/g' |\
  xargs -P 12 -n 1 -I {} tofu state show {}
}


function tfplang () {
  # plan but grep for 'will be' to list all addresses
  if fd -q '.*tfvars' .; then
    extra="-var-file=$(tofu workspace show).tfvars"
  else
    extra=""
  fi
  tofu plan $extra "$@" | grep 'will be'
}

# Tofu Functions
function tfplan () {
  if fd -q '.*tfvars' .; then
    extra="-var-file=$(tofu workspace show).tfvars"
  else
    extra=""
  fi
  tofu plan $extra "$@"
}
function tfapply () {
  if fd -q '.*tfvars' .; then
    extra="-var-file=$(tofu workspace show).tfvars"
  else
    extra=""
  fi
  tofu apply $extra "$@"
}
function tfupgrade () {
  tofu init --upgrade
}
function tfinit () {
  echo "removing .terraform dir"
  rm -rf .terraform*
  echo "tofu init --upgrade"
  tofu init --upgrade
}
function tfproviders () {
  tofu providers
}
function tfimport () {
  if fd -q '.*tfvars' .; then
    extra="-var-file=$(tofu workspace show).tfvars"
  else
    extra=""
  fi
  tofu import $extra "$@"
}
function tfrefresh () {
  if fd -q '.*tfvars' .; then
    extra="-var-file=$(tofu workspace show).tfvars"
  else
    extra=""
  fi
  tofu refresh $extra "$@"
}
function tfdestroy () {
  if fd -q '.*tfvars' .; then
    extra="-var-file=$(tofu workspace show).tfvars"
  else
    extra=""
  fi
  tofu destroy $extra "$@"
}
function tfconsole () {
  if fd -q '.*tfvars' .; then
    extra="-var-file=$(tofu workspace show).tfvars"
  else
    extra=""
  fi
  tofu console $extra "$@"
}
function tfplanall () {
  for workspace in $(tofu workspace list | awk '{print $NF}' | grep -v "default"); do
    tofu workspace select "${workspace}" || break
    if fd -q '.*tfvars' .; then
      extra="-var-file=${workspace}.tfvars"
    else
      extra=""
    fi
    if ! tofu plan $extra -detailed-exitcode; then
      read -e "?$workspace - Plan identified changes. Hit enter to continue"$'\n'
    fi
  done
}
function tfapplyall () {
  for workspace in $(tofu workspace list | awk '{print $NF}' | grep -v "default"); do
    tofu workspace select "${workspace}" || break
    if fd -q '.*tfvars' .; then
      extra="-var-file=${workspace}.tfvars"
    else
      extra=""
    fi
    tofu apply $extra
  done
}

#################################
#           KUBECTL             #
#################################
alias kctl="kubectl"
alias curlbox="kubectl run --rm msorlie-tmp-curl-$(head -c 5 /dev/urandom | base64 | tr -d '=/+' | tr '[:upper:]' '[:lower:]') --image=curlimages/curl -i --tty -- sh"
alias redisbox="kubectl run --rm msorlie-tmp-redis --image=redis:7 -i --tty -- /bin/bash"
alias utilbox="kubectl run msorlie-tmp-utilbox-$(head -c 5 /dev/urandom | base64 | tr -d '=/+' | tr '[:upper:]' '[:lower:]') --rm -i --tty --image nicolaka/netshoot -- /bin/bash"
# alias kubetail="kubectl logs -f"
alias kconfigyaml="kubectl get configmaps | grep -v NAME | cut -f1 -d' ' | fzf | xargs -I {} kubectl get configmap {} -o yaml"
alias ksecretyaml="kubectl get secrets | grep -v NAME | cut -f1 -d' ' | fzf | xargs -I {} kubectl get secrets {} -o yaml"
alias kevents="kubectl get events --sort-by=.metadata.creationTimestamp"
alias ksniff="kubectl sniff -n default"
alias k='kubectl'

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"


#################################
#           GCLOUD              #
#################################

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/miles.sorlie/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/miles.sorlie/.local/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/miles.sorlie/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/miles.sorlie/.local/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="$PATH:/Users/milessorlie/google-cloud-sdk/bin"
export CLOUDSDK_PYTHON=$(which python3.11)
export CLOUDSDK_PYTHON="/usr/bin/python3"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

alias gswitch="gcloud projects list | grep ^onx | awk '{ print \$1 }' | fzf | xargs -n1 -I {} gcloud config set project {}"
alias describerole="gcloud iam roles describe"

function getsecret() {
  gcloud secrets list |\
    grep -v '^NAME' |\
    grep -v '^$' |\
    awk '{ print $1 }' |\
    fzf --header="GCLOUD PROJECT: $(gcloud config get project)" |\
    xargs -n1 -I {} bash -c "cat <(echo 'secret: {}') <(gcloud secrets versions access latest --secret={}) | less"
}

function gcloudreadlogs() {
  app="$1"
  msgKey="$2"
  if [ -z "$msgKey" ]; then 
    msgKey="message"
  fi

  gcloud logging read "resource.type=\"k8s_container\" labels.\"k8s-pod/app\":\"$app\"" --format="value(jsonPayload.$msgKey)"
}

function showgcprole () {
  if [ ! -f /tmp/GCP_PREDEFINED_ROLES ]; then
    echo "/tmp/GCP_PREDEFINED_ROLES is NOT populated, getting all roles..."
    gcloud iam roles list --format="get(name)" > /tmp/GCP_PREDEFINED_ROLES
  fi
  cat /tmp/GCP_PREDEFINED_ROLES | fzf --header "describe role:" | xargs gcloud iam roles describe
}

function showrolesformember() {
  project="$1"
  member="$2"

  if [ -z "$project" ] || [ -z "$member" ]; then
    echo "Usage: showrolesformember <project-id> <member>"
  else
    gcloud projects get-iam-policy $project \
      --flatten="bindings[].members" \
      --filter="bindings.members:$member" \
      --format="table(bindings.role)"
  fi
}

export PATH=$PATH:$HOME/.tfenv/bin

export TF_CLI_ARGS_plan="-parallelism=100"
export TF_CLI_ARGS_apply="-parallelism=100"




if [[ -e "$HOME/.local/bin/kbc-ac.sh" ]]; then
    source $HOME/.local/bin/kbc-ac.sh
    alias kp="kubectl get pods -L project"
fi

export K9S_CONFIG_DIR="$HOME/.config/k9s"


# fixes issue when doing docker-compose build
# Follow link in https://github.com/google-github-actions/setup-gcloud/issues/128#issuecomment-663215962
export LD_LIBRARY_PATH=/usr/local/lib


export ERL_AFLAGS="-kernel shell_history enabled"
# export ERL_COMPILER_OPTIONS=bin_opt_info
# export KERL_CONFIGURE_OPTIONS="--disable-debug --without-javac -with-ssl=/usr/local/ssl"
export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl@1.1)"
export KERL_BUILD_DOCS="yes"

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

export PATH="$HOME/.mix/escripts:$PATH"

export PATH="$PATH:protoc-gen-elixir"

export PATH="$PATH:/usr/lib/elixir/1.11.4/bin"

export PATH="$PATH:/usr/local/mysql/bin"

export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --enable-darwin-64bit --with-ssl=$(brew --prefix openssl)"

if [[ -f "$HOME/.asdf/asdf.sh" ]]; then
    source $HOME/.asdf/asdf.sh
fi

# if [[ -f "$HOME/.asdf/completions/asdf.bash" ]]; then
#     source $HOME/.asdf/completions/asdf.bash
# fi

#################################
#           FZF                 #
#################################

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --multi --bind up:preview-up,down:preview-down'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# source /usr/share/doc/fzf/examples/key-bindings.zsh

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
export PATH="$PATH:/opt/homebrew/Cellar/bash/5.2.32/bin"

# kubectl package manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# add wireshark executable to path
export PATH="$PATH:/Applications/Wireshark.app/Contents/MacOS"

# command line copy/paste
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export EDITOR="/opt/homebrew/bin/nvim"

# if [[ -f "$HOME/gitroot/src/z/z.sh" ]]; then
#   source $HOME/gitroot/src/z/z.sh
# fi

eval "$(zoxide init zsh)"

bindkey -s ^f "tmux-sessionizer\n"

function rename_tmux_window() {
  tmux rename-window $(basename `pwd`)
  echo "renamed tmux window"
}

alias trn="tmux rename-window $(basename `pwd`) &&  echo \"renamed tmux window\""
alias trn2="rename_tmux_window"

alias killsessions="tmux list-sessions | awk 'BEGIN { FS=\":\" } { print \$1 }' | fzf --height=50% | xargs -n1 -I {} bash -c \"tmux kill-session -t {}; echo 'killed session {}'\""

# Tmuxifier
# export PATH="$HOME/.tmuxifier/bin:$PATH"
# export TMUXIFIER_LAYOUT_PATH="$HOME/.tmux-layouts"
# eval "$(tmuxifier init -)"

# export LS_COLORS=$LS_COLORS:'di=0;35:'

# don't auto-cd into a dir by typing its name
unsetopt AUTO_CD

# share history between sessions
setopt share_history

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


# The next line enables shell command completion for gcloud.
export PATH="/opt/homebrew/opt/lua@5.3/bin:$PATH"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# make nvim the man pager
# export MANPAGER='nvim +Man!'
