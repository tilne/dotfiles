function pcaf --wraps='pre-commit run --verbose --all-files' --description 'alias pcaf=pre-commit run --verbose --all-files'
  pre-commit run --verbose --all-files $argv; 
end
