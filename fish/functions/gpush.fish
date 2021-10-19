# Defined in - @ line 1
function gpush --wraps='git push' --description 'alias gpush=git push'
  git push $argv;
end
