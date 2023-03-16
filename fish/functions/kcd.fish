function kcd --wraps='kubectl describe' --description 'alias kcd=kubectl describe'
  kubectl describe $argv; 
end
