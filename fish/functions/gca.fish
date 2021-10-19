# Defined in - @ line 1
function gca --wraps='git commit -v --amend' --description 'alias gca=git commit -v --amend'
  git commit -v --amend $argv;
end
