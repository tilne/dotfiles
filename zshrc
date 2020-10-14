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
