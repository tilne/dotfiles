# Defined in - @ line 1
function gspop --wraps='git stash pop' --description 'alias gspop=git stash pop'
  git stash pop $argv;
end
