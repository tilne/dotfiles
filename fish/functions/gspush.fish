# Defined in - @ line 1
function gspush --wraps='git stash push -m' --description 'alias gspush=git stash push -m'
  git stash push -m $argv;
end
