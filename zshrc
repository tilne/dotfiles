#!/bin/zsh
export ZSH="${HOME}/.oh-my-zsh"
ZSH_THEME="tilne-junkfood"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

set -o emacs
export LSCOLORS='fxfxcxdxgxegedabagacad'
export EDITOR="vim"
export PATH=$PATH:~/.toolbox/bin:${HOME}/repos/tilne-utils:${HOME}/bin:/usr/local/bin
export TMPDIR='/tmp'
export PYTHONSTARTUP="$HOME/.pythonrc"
source ~/.secrets
source ~/.aliases

ssh-add ~/.ssh/tilne.pem

# pyenv initialization
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Emulate bash CTL+U behavior
bindkey \^U backward-kill-line
