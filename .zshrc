# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# (d) is default on

# ------------------------------
# ZSH Settings
# ------------------------------
export ZSH="/Users/tsukaby/.oh-my-zsh"
ZSH_THEME="candy"
plugins=(
    git
)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-completions
autoload -U compinit && compinit -u
source $ZSH/oh-my-zsh.sh


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
autoload -U compinit; compinit
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
# Look And Feel Settings
# ------------------------------
### Ls Color ###
export LSCOLORS=Exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
autoload -U colors; colors
tmp_prompt="%F{cyan}[%n@%m %C]%f%# "
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# root user is bold and underline
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt
PROMPT2=$tmp_prompt2
SPROMPT=$tmp_sprompt
# Ssh login prompt
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

#Title
precmd() {
    [[ -t 1 ]] || return
    case $TERM in
        *xterm*|rxvt|(dt|k|E)term)
        print -Pn "\e]2;[%~]\a"
;;
        # screen)
        #      #print -Pn "\e]0;[%n@%m %~] [%l]\a"
        #      print -Pn "\e]0;[%n@%m %~]\a"
        #      ;;
    esac
}


# ------------------------------
# Other Settings
# ------------------------------

### Aliases ###
alias history='history -E'
alias ll='ls -l'
alias dl='docker ps -l -q'
alias drm='docker rm `docker ps -a -q`'

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
# shell起動が少し遅くなるのでできれば避けたい
eval "$(direnv hook zsh)"

# OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
