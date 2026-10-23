#!/bin/bash
set -eo pipefail

rm -f /vagrant/node-token

mkdir -p /etc/rancher/k3s
cp /vagrant/confs/server.yaml /etc/rancher/k3s/config.yaml

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=$NODE_IP --tls-san=$NODE_IP" sh -

while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
  sleep 1
done

cp /var/lib/rancher/k3s/server/node-token /vagrant/node-token
