function kcg --wraps='kubectl get' --description 'alias kcg=kubectl get'
  kubectl get $argv; 
end
