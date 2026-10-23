#!/bin/bash
set -eo pipefail

TIMEOUT=300
while [ ! -f /vagrant/node-token ]; do
  if [ $TIMEOUT -le 0 ]; then
    echo "Timed out waiting for /vagrant/node-token from the server" >&2
    exit 1
  fi
  sleep 1
  TIMEOUT=$((TIMEOUT - 1))
done

TOKEN=$(cat /vagrant/node-token)

mkdir -p /etc/rancher/k3s
cp /vagrant/confs/agent.yaml /etc/rancher/k3s/config.yaml

curl -sfL https://get.k3s.io | K3S_URL="https://$SERVER_IP:6443" K3S_TOKEN="$TOKEN" INSTALL_K3S_EXEC="--node-ip=$NODE_IP" sh -
