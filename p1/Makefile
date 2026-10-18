.SILENT:

PURPLE  := \033[1;35m
GREEN   := \033[1;32m
RED     := \033[1;31m
YELLOW  := \033[1;33m
CYAN    := \033[1;36m
RESET   := \033[0m

VAGRANT := vagrant

.PHONY: all
all: up

.PHONY: up
up:
	echo "$(GREEN)Starting VMs...$(RESET)"
	$(VAGRANT) up

.PHONY: halt
halt:
	echo "$(YELLOW)Stopping VMs...$(RESET)"
	$(VAGRANT) halt

.PHONY: reload
reload:
	echo "$(YELLOW)Reloading VMs...$(RESET)"
	$(VAGRANT) reload

.PHONY: destroy
destroy:
	echo "$(RED)Destroying VMs...$(RESET)"
	$(VAGRANT) destroy -f

.PHONY: re
re: destroy up

.PHONY: status
status:
	echo "$(CYAN)VM status:$(RESET)"
	$(VAGRANT) status

.PHONY: ssh-server
ssh-server:
	echo "$(CYAN)Connecting to server node...$(RESET)"
	$(VAGRANT) ssh tariniS

.PHONY: ssh-worker
ssh-worker:
	echo "$(CYAN)Connecting to worker node...$(RESET)"
	$(VAGRANT) ssh asekkakSW

.PHONY: nodes
nodes:
	echo "$(YELLOW)Checking K3s nodes from server...$(RESET)"
	$(VAGRANT) ssh tariniS -c "sudo kubectl get nodes -o wide"

.PHONY: clean
clean: destroy
	echo "$(RED)Removing Vagrant box cache metadata...$(RESET)"
	rm -rf .vagrant

.PHONY: help
help:
	echo "$(PURPLE)╔══════════════════════════════════════════╗$(RESET)"
	echo "$(PURPLE)║        Inception-of-Things - P1          ║$(RESET)"
	echo "$(PURPLE)╚══════════════════════════════════════════╝$(RESET)"
	echo ""
	echo "$(GREEN)VM lifecycle:$(RESET)"
	echo "  make up          - create/start both VMs"
	echo "  make halt        - stop both VMs"
	echo "  make reload      - restart VMs (reload config)"
	echo "  make destroy     - delete both VMs"
	echo "  make re          - destroy + up (fresh rebuild)"
	echo ""
	echo "$(YELLOW)Inspect:$(RESET)"
	echo "  make status      - show VM state"
	echo "  make nodes       - show kubectl get nodes from server"
	echo ""
	echo "$(CYAN)Access:$(RESET)"
	echo "  make ssh-server  - ssh into tariniS"
	echo "  make ssh-worker  - ssh into asekkakSW"
	echo ""
	echo "$(RED)Cleanup:$(RESET)"
	echo "  make clean       - destroy + remove .vagrant cache"