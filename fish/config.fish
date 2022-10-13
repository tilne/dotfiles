# PATH
fish_add_path -a ~/.pyenv/bin

# pyenv
status --is-interactive; and source (pyenv init -| psub); and source (pyenv virtualenv-init -| psub)
test -z "$PYENV_VIRTUAL_ENV"; and pyenv activate develop
fish_add_path -a ~/.pyenv/shims

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
