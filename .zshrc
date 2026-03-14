# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# ------------------------------
# ZSH Core Settings
# ------------------------------
# 補完の初期化 (oh-my-zsh が担っていた部分を自前で実行)
autoload -Uz compinit && compinit

# Plugins (Homebrew経由でインストール)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# z (directory jumper)
. /opt/homebrew/etc/profile.d/z.sh

# Starship prompt
eval "$(starship init zsh)"

# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vi
export LANG=ja_JP.UTF-8

# Android
export ANDROID_HOME=/usr/local/opt/android-sdk

# Scala
export SCALA_HOME=/usr/local/opt/scala/idea/
export SBT_OPTS="-Xms1G -Xmx1G -Xss2M"

# Go
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# AWS EKS
export KUBECONFIG=$KUBECONFIG:~/.kube/config-test

# Secret settings
source ~/.zshrc_secret

bindkey -e

setopt auto_pushd
setopt prompt_subst
setopt notify

### Complement ###
setopt auto_list
setopt list_packed
setopt list_types
# Shift-Tab reverse completion
bindkey "^[[Z" reverse-menu-complete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### History ###
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt bang_hist
setopt extended_history
setopt hist_ignore_dups
setopt share_history
setopt hist_reduce_blanks

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

function history-all { history -E 1 }

# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias history='history -E'
alias ll='ls -l'
alias dl='docker ps -l -q'
alias drm='docker rm `docker ps -a -q`'

# oh-my-zsh git plugin から引き継ぎ (よく使うもののみ)
alias g='git'
alias gst='git status'
alias gco='git checkout'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gb='git branch'
alias glog='git log --oneline --decorate --graph'

# execute ls after cd
function cd() {
  builtin cd $@ && ls;
}

export PGDATA=/usr/local/var/postgres

function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# pg gem用
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Auto run direnv
eval "$(direnv hook zsh)"

# OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Antigravity
export PATH="/Users/tsukaby/.antigravity/antigravity/bin:$PATH"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
