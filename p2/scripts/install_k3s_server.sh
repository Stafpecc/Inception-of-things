#!/bin/bash

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110 --flannel-iface=enp0s8 --tls-san=192.168.56.110 --disable metrics-server --write-kubeconfig-mode=644" sh -

