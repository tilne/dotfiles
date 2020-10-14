#!/bin/zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
  alias vim=nvim
fi

set -o emacs
export LSCOLORS='fxfxcxdxgxegedabagacad'
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$PATH:~/.toolbox/bin:${HOME}/repos/tilne-utils:${HOME}/bin:/usr/local/bin
export TMPDIR='/tmp'
export PYTHONSTARTUP="$HOME/.pythonrc"
source ~/.aliases
source ~/.secrets

# pyenv initialization
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Emulate bash CTL+U behavior
bindkey \^U backward-kill-line

export PROMPT="
%F{cyan}(%D %*) <%?> [%~] $program %{$fg[default]%}
%F{magenta} %#%F{default} "

#####
#
# The following autocompletion config was taken from:
# https://www.codyhiar.com/blog/zsh-autocomplete-with-ssh-config-file/
#
#####

# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Initialize the autocompletion
autoload -Uz compinit && compinit -i
