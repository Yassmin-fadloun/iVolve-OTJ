# SSH Configuration : Key Authentication and Host Alias

## Objective

Set up SSH key-based access between two EC2 instances and simplify SSH access using a custom alias.

---

## Procedure

### 1. Launch Two EC2 Instances

- Instance 1: Will act as your **local or source machine**.
- Instance 2: Will be your **remote target machine**.

Ensure both:
- Are in the same **Availability Zone** (optional but helps with latency).
- Have **port 22 open** in their Security Groups for SSH access.

---

### 2. SSH into Instance 1 (Your Local)

Use the AWS key pair to SSH into Instance 1:

```bash
ssh -i "your-key.pem" ubuntu@<instance-1-public-ip>
```

---

### 3. Generate SSH Key Pair on Instance 1

```bash
ssh-keygen -t ed25519
```

- When prompted to enter a file, just press **Enter** to accept default:  
  `/home/ubuntu/.ssh/id_ed25519`

- This will generate:
  - Private key: `~/.ssh/id_ed25519`
  - Public key: `~/.ssh/id_ed25519.pub`

---

### 4. Copy the Public Key to Instance 2

From Instance 1, run:

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub ubuntu@<instance-2-public-ip>
```

If `ssh-copy-id` is not available, use the manual method:

```bash
cat ~/.ssh/id_ed25519.pub | ssh ubuntu@<instance-2-public-ip> \
'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
```

---

### 5. Test SSH Login to Instance 2

Now try logging in **without a password** from Instance 1:

```bash
ssh ubuntu@<instance-2-public-ip>
```

If successful, you're now using **key-based authentication**.

---

### 6. Configure SSH Alias for Easier Access

Create or edit SSH config file on Instance 1:

```bash
nano ~/.ssh/config
```

Add the following:

```
Host ivolve
    HostName <instance-2-public-ip>
    User ubuntu
    IdentityFile ~/.ssh/id_ed25519
```

Save the file.

---

### 7. Connect Using the Alias

Now you can connect to Instance 2 by simply running:

```bash
ssh ivolve
```

No IP needed, no `-i` flag needed.

---

## Included Fi9les

- [config](config): SSH configuration file with alias setup.
- `id_ed25519.pub`: Public key file you shared with the remote instance.

---

## Notes

- If the alias doesn’t work, verify:
  - File permissions: `chmod 600 ~/.ssh/config`
  - HostName/IP is correct
  - `IdentityFile` points to the correct private key

- You can add multiple hosts in the config file for other machines.

---

## Summary

This lab demonstrates a secure and efficient way to connect between systems by:
- Avoiding passwords
- Using encrypted SSH key pairs
- Creating a shortcut using the SSH config file

