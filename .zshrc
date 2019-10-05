# (d) is default on

# ------------------------------
# ZSH Settings
# ------------------------------
export ZSH="/Users/tsukaby/.oh-my-zsh"
ZSH_THEME="candy"
plugins=(
    git
    zsh-syntax-highlighting
    zsh-completions
)

# zsh-completions
autoload -U compinit && compinit -u
source $ZSH/oh-my-zsh.sh


# ------------------------------
# General Settings
# ------------------------------
export EDITOR=emacs
export LANG=ja_JP.UTF-8
# Add homebrew path
path=(
    /usr/local/bin(N-/)
    $HOME/.rbenv/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    $path
)

fpath=(/usr/local/share/zsh-completions $fpath)
    
# AWS ec2-api-tools
export JAVA_HOME="$(/usr/libexec/java_home)"
if [ -e "$HOME/.ec2" ]; then
    export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
    export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
fi
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.6.12.0/libexec"

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

# Ruby (rbenv)
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv completion
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

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
alias dockerc='docker-compose'
alias dockerm='docker-machine'
alias rspec-custom="bundle exec rspec --exclude-pattern='spec/features/*'"

# execute ls after cd
function cd() {
  builtin cd $@ && ls;
}

export PGDATA=/usr/local/var/postgres

# The next line updates PATH for the Google Cloud SDK.
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# The next line enables shell command completion for gcloud.
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# Docker settings
docker-machine start
eval $(docker-machine env)
