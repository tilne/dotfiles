function pc --wraps='pre-commit run --verbose' --description 'alias pc=pre-commit run --verbose'
  pre-commit run --verbose $argv; 
end
