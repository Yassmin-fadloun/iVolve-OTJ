# Disk Management: LVM Setup and Extension

## Objective

Configure Logical Volume Management on a 6 GB attached disk.

---

## Procedure

### 1. Attach EBS Volume (6 GB)
- Create it from AWS EC2 console.
- Attach to your EC2 instance (e.g., `/dev/nvme1n1`).

### 2. Verify the New Disk

```bash
lsblk
```

You should see something like:

```
nvme0n1   8G
├─nvme0n1p1 ...
nvme1n1   6G   # <--- new disk
```

---

### 3. Partition the 6 GB Disk into Two Parts (2G and 3G)

```bash
sudo fdisk /dev/nvme1n1
```

Inside fdisk:
- Press `n` → Enter → Enter → `+2G`
- Press `n` → Enter → Enter → `+3G`
- Press `w` to write and exit

---

### 4. Confirm the Partitions

```bash
lsblk
```

You should now see:

```
nvme1n1
├─nvme1n1p1   2G
└─nvme1n1p2   3G
```

---

### 5. Create Physical Volumes

```bash
sudo pvcreate /dev/nvme1n1p1
sudo pvcreate /dev/nvme1n1p2
```

---

### 6. Create Volume Group (VG) Using the 2G Partition

```bash
sudo vgcreate my_vg /dev/nvme1n1p1
```

---

### 7. Create Logical Volume (LV)

```bash
sudo lvcreate -L 1.5G -n my_lv my_vg
```

---

### 8. Format the Logical Volume with ext4

```bash
sudo mkfs.ext4 /dev/my_vg/my_lv
```

---

### 9. Mount the Logical Volume

```bash
sudo mkdir /mnt/lvm_volume
sudo mount /dev/my_vg/my_lv /mnt/lvm_volume
```

---

### 10. Extend Volume Group by Adding 3G Partition

```bash
sudo vgextend my_vg /dev/nvme1n1p2
```

---

### 11. Extend Logical Volume to Use All Free Space

```bash
sudo lvextend -l +100%FREE /dev/my_vg/my_lv
```

---

### 12. Resize Filesystem to Use the New Space

```bash
sudo resize2fs /dev/my_vg/my_lv
```

---

### 13. Confirm Size of the Logical Volume

```bash
df -hT /mnt/lvm_volume
```

---


Output:
- [lvm_commands.txt](lvm_commands.txt)

---
## Notes

- You can unmount the logical volume with:
  ```bash
  sudo umount /mnt/lvm_volume
  ```
- Use `sudo pvdisplay` to see LVM details.
