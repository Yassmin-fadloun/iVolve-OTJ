# Ansible Installation 

## Objective
Install and configure Ansible to manage a remote node using ad-hoc commands.

## Setup

- **Control Node**: EC2 Instance 1
- **Managed Node**: EC2 Instance 2
- **OS**: Ubuntu 22.04 on both

---

## Steps

### 1. Install Ansible on Control Node

```bash
sudo apt update
sudo apt install -y ansible
ansible --version
```
## 2. Generate an SSH key on the control node to be used by Ansible:
```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ansible
```

## 3. Copy the public key to the managed node using ssh-copy-id:
```bash
ssh-copy-id -i ~/.ssh/id_ansible.pub ubuntu@<MANAGED_NODE_PUBLIC_IP>
```

## 4. Create an inventory file for Ansible on the control node:
```bash
mkdir ~/ansible-lab
cd ~/ansible-lab
nano inventory.ini
```
## 5. [Inventory.ini](Inventory.txt) content:
```bash
[managed]
managed-node ansible_host=(Private ip) ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_ansible
```
## 6. Test connection using Ansible’s ping module:
```bash
ansible -i inventory.ini managed -m ping
```

## Output:
```bash
managed-node | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
## Files Included
- [Inventory.ini](Inventory.txt) — Ansible inventory file with managed node details

