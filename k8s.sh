#!/bin/bash

echo -e "\n\n Short description of used alias:\n
- k -> shorter version of kubectl -n <namespace>
- ke -> allow edit resources
- kd -> allow to describe resource
- krh -> print rollout history
- kru -> make rollout undo
- kc -> create new resource
- kex -> allow exec into pod
- kl -> print logs from resource
- ka -> list all resources in cluster
"

# Shorter versions of k8s kubectl commands
namespace=$1

alias k="kubectl -n ${namespace}"
alias ke="kubectl -n ${namespace} edit"
alias kd="kubectl -n ${namespace} describe"
alias krh="kubectl -n ${namespace} rollout history"
alias kru="kubectl -n ${namespace} rollout undo"
alias kc="kubectl -n ${namespace} create"
alias kex="kubectl -n ${namespace} exec -it"
alias kl="kubectl -n ${namespace} logs"
alias ka="kubectl get all -o wide"
