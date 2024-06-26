#!/bin/bash
set -o emacs
export LSCOLORS='fxfxcxdxgxegedabagacad'
export PS1='\[\e[32m\]\u\[\e[0m\]@\[\e[32m\]\h\[\e[0m\]:\[\e[32m\]\W\[\e[32m\]> \[\e[0m\]'
export PATH=$PATH:~/.toolbox/bin:/usr/local/bin
export PATH=/usr/local/Cellar/gnu-sed/4.8/libexec/gnubin/sed:${PATH}
export EDITOR="vim"
export TMPDIR='/tmp'
export PYTHONSTARTUP="$HOME/.pythonrc"
source ~/.aliases
source ~/.secrets

ssh-add &>/dev/null ~/.ssh/tilne.pem
source ~/.iterm2_shell_integration.bash

# pyenv initialization
export PATH="/Users/$(whoami)/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
