# PATH
fish_add_path -ga /opt/homebrew/bin
fish_add_path -ga /opt/homebrew/sbin

# MANPATH
set -gx MANPATH "$MANPATH:/opt/homebrew/share/man"

# includes and shared libs
set -gx CPPFLAGS "$CPPFLAGS -I/opt/homebrew/opt/openjdk/include -I/opt/homebrew/Cellar/librdkafka/1.9.2/include -I/opt/homebrew/opt/openblas/include"
set -gx LDFLAGS "$LDFLAGS -L/opt/homebrew/opt/openblas/lib -I/opt/homebrew/Cellar/librdkafka/1.9.2/lib"

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
