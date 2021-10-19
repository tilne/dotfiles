# Defined in - @ line 1
function tl --wraps='tmux ls' --description 'alias tl=tmux ls'
  tmux ls $argv;
end
