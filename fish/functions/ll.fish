# Defined in - @ line 1
function ll --wraps='ls -lG --color=auto' --description 'alias ll=ls -lG --color=auto'
  ls -lG --color=auto $argv;
end
