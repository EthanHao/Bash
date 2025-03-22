```markdown
# Linux Disk Commands Cheat Sheet

## Listing Disks & Partitions
### **`lsblk`**  
List block devices (disks, partitions, LVM).  
```bash
lsblk                  # Tree view
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT  # Custom columns
```

### **`fdisk`** / **`parted`**  
Disk partitioning tools.  
```bash
sudo fdisk -l          # List partitions (legacy)
sudo parted -l         # Modern partition details
```

### **`blkid`**  
Show block device UUIDs and filesystems.  
```bash
blkid                  # All devices
blkid /dev/sda1        # Specific partition
```

---

## Disk Usage & Space
### **`df`**  
Report filesystem disk space usage.  
```bash
df -h                  # Human-readable (GB/MB)
df -Th                 # Include filesystem type
```

### **`du`**  
Estimate file/directory space usage.  
```bash
du -sh /path           # Summary of directory size
du -ah --max-depth=1   # All files, 1 level deep
```

---

## Partitioning & Formatting
### **`gdisk`**  
GPT partitioning tool (for modern disks).  
```bash
sudo gdisk /dev/sdb    # Start partitioning
```

### **`mkfs`**  
Create a filesystem.  
```bash
sudo mkfs.ext4 /dev/sdb1   # Format as ext4
sudo mkfs.ntfs /dev/sdb1   # Format as NTFS
```

### **`fsck`**  
Check/repair filesystems.  
```bash
sudo fsck /dev/sda1    # Unmount first!
```

---

## Mounting & Unmounting
### **`mount`** / **`umount`**  
Mount/unmount filesystems.  
```bash
sudo mount /dev/sdb1 /mnt   # Mount to /mnt
sudo umount /mnt            # Unmount
```

### **`/etc/fstab`**  
Permanent mount configuration.  
```bash
sudo nano /etc/fstab   # Add entries like:
# /dev/sdb1  /data  ext4  defaults  0 2
```

---

## Disk Cloning & Backup
### **`dd`**  
Raw disk cloning (use with caution!).  
```bash
sudo dd if=/dev/sda of=/dev/sdb bs=4M status=progress  # Clone disk
```

### **`rsync`**  
Synchronize files/directories.  
```bash
rsync -avh /source/ /destination/  # Archive mode
```

---

## SMART Monitoring
### **`smartctl`**  
Check disk health (install `smartmontools`).  
```bash
sudo smartctl -a /dev/sda   # Full SMART report
sudo smartctl -H /dev/sda   # Health status
```

---

## LVM (Logical Volume Management)
### **`pvcreate`** / **`vgcreate`** / **`lvcreate`**  
LVM volume setup.  
```bash
sudo pvcreate /dev/sdb1     # Create physical volume
sudo vgcreate vg_data /dev/sdb1  # Create volume group
sudo lvcreate -L 50G -n lv_storage vg_data  # Create logical volume
```

### **`lvs`** / **`vgs`** / **`pvs`**  
List LVM components.  
```bash
lvs                     # Logical volumes
vgs                     # Volume groups
pvs                     # Physical volumes
```

---

## Quick Reference Table
| Command               | Purpose                          | Example                     |
|-----------------------|----------------------------------|-----------------------------|
| `lsblk`               | List disks/partitions            | `lsblk -o NAME,SIZE`       |
| `df -h`               | Check free space                 | `df -h /home`              |
| `sudo mkfs.ext4`      | Format partition                 | `sudo mkfs.ext4 /dev/sdb1` |
| `sudo mount`          | Mount a filesystem               | `sudo mount /dev/sdb1 /mnt`|
| `dd`                  | Clone disks                      | `dd if=/dev/sda of=backup.img` |
| `smartctl -H`         | Check disk health                | `sudo smartctl -H /dev/sda`|

---

## Troubleshooting Tips
1. **Disk Full**:  
   - Use `du -sh *` to find large directories.  
   - Clear old logs (`/var/log`) or temporary files (`/tmp`).  

2. **Mount Errors**:  
   - Check filesystem: `sudo fsck /dev/sdb1`.  
   - Verify UUID in `/etc/fstab` with `blkid`.  

3. **Slow Disk I/O**:  
   - Monitor with `iostat -x 2` (install `sysstat`).  

4. **LVM Resizing**:  
   - Extend a logical volume:  
     ```bash
     sudo lvextend -L +10G /dev/vg_data/lv_storage
     sudo resize2fs /dev/vg_data/lv_storage
     ```

---

**Note**: Replace `/dev/sdX` with your actual disk/partition.  
**Pro Tip**: Use `ncdu` for interactive disk usage analysis (`sudo apt install ncdu`).  
Save this as `disk_commands.md`! 💾
```
