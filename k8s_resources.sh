#!/bin/bash

function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found ${i}
  done
}

function main() {
  echo "######################### ALL K8S RESOURCES ####################################"
  kubectlgetall ${1}
}

main ${1}
