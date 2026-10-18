# K3s Server Configuration Flags

| Flag | Why I added it |
|---|---|
| `--node-ip=192.168.56.110` | Forces K3s to use the private IP explicitly instead of guessing (and risking picking the NAT IP 10.0.2.15, which is invisible from the other VM) |
| `--flannel-iface=enp0s8` | Forces the pod network (Flannel CNI) to go through the private interface, not the NAT one |
| `--tls-san=192.168.56.110` | Adds this IP to the list of valid names in the server's TLS certificate, to avoid certificate errors when connecting via this IP |
| `--disable traefik` | P1 doesn't need an Ingress controller — Traefik was consuming unnecessary resources on a 1 CPU/1GB VM |
| `--disable servicelb` | Same reasoning: K3s's built-in load balancer is only useful for exposing Services as LoadBalancer, not needed here |
| `--disable metrics-server` | Same reasoning: metrics collection (pod CPU/RAM) isn't required just to get the cluster running |
| `--write-kubeconfig-mode=644` | Makes the kubeconfig file readable without sudo, so kubectl works normally |

# K3s Agent Configuration Flags

| Flag | Why |
|---|---|
| `--node-ip=192.168.56.111` | Same reason as the server: force the private IP |
| `--flannel-iface=enp0s8` | Same reason: pod network consistency |

# Vagrantfile-level Setting (not a K3s flag)

| Setting | Why |
|---|---|
| `ethtool -K enp0s8 tx off rx off gso off gro off tso off` (with `run: "always"`) | Fixes a network offloading bug that was hanging the TLS handshake between the two VMs on the private interface |

# Ressources

https://blog.stephane-robert.info/docs/infra-as-code/provisionnement/vagrant/

https://www.youtube.com/watch?v=5hmsWOmI2kY

https://docs.k3s.io/quick-start
