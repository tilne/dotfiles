# Defined in - @ line 1
function gc --wraps='git commit -sv' --description 'alias gc=git commit -sv'
  git commit -sv $argv;
end
