if command -v kubectl > /dev/null
  kubectl completion fish | source
end

if command -v minikube > /dev/null
  minikube completion fish | source
end

if command -v helm > /dev/null
  helm completion fish | source
end
