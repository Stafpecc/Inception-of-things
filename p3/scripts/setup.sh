#!/bin/bash
set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! k3d cluster get iot >/dev/null 2>&1; then
    k3d cluster create iot -p "8888:80@loadbalancer" --wait
fi

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace dev --dry-run=client -o yaml | kubectl apply -f -

kubectl apply -n argocd --server-side --force-conflicts \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait --for=condition=Established crd/applications.argoproj.io --timeout=120s
kubectl wait --for=condition=Available deployment --all -n argocd --timeout=300s

kubectl apply -f "$SCRIPT_DIR/../confs/application.yaml"