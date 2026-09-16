# Inception-of-Things (IoT)

A minimal introduction to Kubernetes, built across three mandatory parts plus a bonus, using Vagrant, K3s, K3d, and Argo CD.

## Repository structure

```
.
├── p1/
│   ├── Vagrantfile
│   ├── scripts/
│   └── confs/
├── p2/
│   ├── Vagrantfile
│   ├── scripts/
│   └── confs/
├── p3/
│   ├── scripts/
│   └── confs/
└── bonus/
    ├── Vagrantfile
    ├── scripts/
    └── confs/
```

## Part 1 — K3s and Vagrant

Set up two virtual machines with Vagrant, using minimal resources (1 CPU, 512MB–1GB RAM):

- **Server VM** — hostname ending in `S`, static IP `192.168.56.110`, K3s installed in **server (controller)** mode
- **ServerWorker VM** — hostname ending in `SW`, static IP `192.168.56.111`, K3s installed in **agent** mode, joined to the controller
- Passwordless SSH access to both machines
- `kubectl` installed to interact with the cluster

## Part 2 — K3s and three simple applications

Using a single VM (K3s in server mode), deploy **three web apps** behind one Ingress, routed by hostname on `192.168.56.110`:

- `app1.com` → serves app1
- `app2.com` → serves app2 (**3 replicas**)
- any other host → defaults to app3

## Part 3 — K3d and Argo CD

This part runs **without Vagrant** — everything happens directly on the VM, installed via a setup script (Docker + K3d + dependencies).

- Create a **K3d** cluster
- Deploy **Argo CD** with two namespaces:
  - `argocd` — for Argo CD itself
  - `dev` — hosting the application Argo CD deploys
- Application source: either Wil's pre-built image (`wil42/playground`, port 8888) or your own, pushed to a public Docker Hub repo with two tags (`v1`, `v2`)
- Push manifests to a **public GitHub repo** (must include a team member's login in the repo name)
- Argo CD watches the repo and auto-syncs the cluster; changing the image tag in `deployment.yaml` and pushing should trigger a redeploy to the new version, verifiable via `curl` on port 8888

## Bonus — GitLab integration

Only evaluated if the mandatory part is fully flawless.

- Deploy a **local GitLab instance** (latest version), in its own `gitlab` namespace
- Configure it to work with the existing cluster
- Everything from Part 3 (Argo CD sync, dev deployment, versioning) must keep working through this local GitLab
- Helm is allowed/recommended to simplify the GitLab setup
