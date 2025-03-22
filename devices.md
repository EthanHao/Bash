```markdown
# Linux Device Commands Cheat Sheet

## Hardware Detection & Info
### **`lshw`**  
List detailed hardware configuration.  
```bash
sudo lshw -short       # Short summary
sudo lshw -class disk  # Show disks only
```

### **`lspci`**  
List PCI devices (GPUs, network cards, etc.).  
```bash
lspci                  # Basic list
lspci -v               # Verbose details
lspci -nn              # Show vendor/device IDs
```

### **`lsusb`**  
List USB devices.  
```bash
lsusb                  # All USB devices
lsusb -v               # Detailed info
```

### **`lsblk`**  
List block devices (disks, partitions).  
```bash
lsblk                  # Tree view of disks
lsblk -o NAME,SIZE,FSTYPE  # Custom columns
```

### **`inxi`**  
System summary tool (install with `sudo apt install inxi`).  
```bash
inxi -F               # Full hardware overview
inxi -D               # Disk details
```

---

## Storage & Disks
### **`fdisk`** / **`parted`**  
Partitioning tools.  
```bash
sudo fdisk -l         # List partitions
sudo parted -l        # Modern partition details
```

### **`mount`** / **`umount`**  
Mount/unmount filesystems.  
```bash
sudo mount /dev/sdb1 /mnt  # Mount a partition
sudo umount /mnt           # Unmount
```

### **`df`** / **`du`**  
Disk usage stats.  
```bash
df -h                 # Human-readable free space
du -sh /path          # Directory size summary
```

### **`smartctl`**  
Check disk health (install `smartmontools`).  
```bash
sudo smartctl -a /dev/sda  # Full disk health report
```

---

## USB Devices
### **`udevadm`**  
Manage and monitor USB device events.  
```bash
udevadm monitor       # Watch USB device changes
udevadm info -a -n /dev/sdb  # Details for a device
```

### **`usb-devices`**  
List USB devices with driver info.  
```bash
usb-devices           # Requires `usbutils` package
```

---

## Kernel Modules (Drivers)
### **`lsmod`**  
List loaded kernel modules.  
```bash
lsmod                 # Show all loaded drivers
```

### **`modinfo`**  
Show module/driver details.  
```bash
modinfo nvidia        # Info about NVIDIA driver
```

### **`modprobe`**  
Load/unload kernel modules.  
```bash
sudo modprobe -r module_name  # Unload a module
sudo modprobe module_name     # Load a module
```

---

## Device Files & Logs
### **`dmesg`**  
View kernel ring buffer (device detection logs).  
```bash
dmesg | grep -i error  # Filter for errors
dmesg -T               # Human-readable timestamps
```

### **`/proc` Files**  
Access device info via virtual files.  
```bash
cat /proc/cpuinfo      # CPU details
cat /proc/meminfo      # Memory stats
cat /proc/partitions   # Partition table
```

### **`/sys` Files**  
Interact with device configurations.  
```bash
ls /sys/class/net      # Network interfaces
ls /sys/block          # Block devices (disks)
```

---

## Quick Reference Table
| Command               | Purpose                          | Example                     |
|-----------------------|----------------------------------|-----------------------------|
| `lspci -nn`           | List PCI devices with IDs        | `lspci -nn`                |
| `lsusb`               | List USB devices                 | `lsusb -v`                 |
| `lsblk`               | Show block devices               | `lsblk -o NAME,SIZE`       |
| `sudo smartctl -a`    | Check disk health                | `sudo smartctl -a /dev/sda`|
| `dmesg \| grep error` | Find device errors               | `dmesg \| grep -i usb`     |
| `inxi -F`             | Full system summary              | `inxi -F`                  |

---

## Troubleshooting Tips
1. **Device Not Detected**:  
   - Check `dmesg` for kernel logs.  
   - Verify drivers with `lsmod`.  

2. **Disk Mounting Issues**:  
   - Use `lsblk` to confirm the device path.  
   - Check filesystem with `fsck /dev/sdb1`.  

3. **Driver Conflicts**:  
   - Unload/reload modules with `modprobe -r` and `modprobe`.  

4. **USB Permissions**:  
   - Ensure user is in the `plugdev` group.  

---

**Note**: Some commands require `sudo` or root access.  
**Pro Tip**: Use `watch -n 1 'dmesg -T'` to monitor device events in real time.  
Save this as `device_commands.md`! 🖥️
```
