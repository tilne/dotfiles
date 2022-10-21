# PATH
fish_add_path -ga /opt/homebrew/bin
fish_add_path -ga /opt/homebrew/sbin

# MANPATH
set -gx MANPATH "$MANPATH:/opt/homebrew/share/man"

# pyenv
set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
status --is-interactive; and source (pyenv init -| psub); and source (pyenv virtualenv-init -| psub)
test -z "$PYENV_VIRTUAL_ENV"; and pyenv activate dev

# nvm
set -x NVM_DIR ~/.nvm

# aliases, secrets
source ~/.secrets.fish

# Disable tmux status line if running in vscode
if test "$TERM_PROGRAM" = "vscode"
    and set -q TMUX
        tmux set-option status off
end

# set some default AWS envs
set -x AWS_DEFAULT_REGION us-east-1

# Set editor
set -gx EDITOR nvim
