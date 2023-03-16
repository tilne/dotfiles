function pwp --wraps='pyenv which python' --description 'alias pwp=pyenv which python'
  pyenv which python $argv; 
end
