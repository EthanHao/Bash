```markdown
# Linux System Services Cheat Sheet

## Managing Services (systemd)

### **`systemctl`**  
Control and monitor systemd services.  
```bash
systemctl start <service>     # Start a service
systemctl stop <service>      # Stop a service
systemctl restart <service>  # Restart a service
systemctl reload <service>    # Reload config without restarting
systemctl enable <service>    # Enable at boot
systemctl disable <service>   # Disable at boot
systemctl status <service>    # Check service status
systemctl list-units --type=service  # List all services
```

### **`journalctl`**  
View service logs.  
```bash
journalctl -u <service>       # Logs for a specific service
journalctl -u nginx --since "1 hour ago"  # Filter by time
journalctl -p err -b          # Show errors since last boot
```

### **`service`**  
Legacy SysVinit command (for older systems).  
```bash
service <service> start        # Start a service
service <service> status       # Check status
```

---

## Service Timers (Scheduled Tasks)
### **`systemctl list-timers`**  
List active scheduled timers.  
```bash
systemctl list-timers --all    # Include inactive timers
```

### **`cron`**  
Traditional task scheduler (use `crontab`).  
```bash
crontab -e                     # Edit user cron jobs
crontab -l                     # List cron jobs
```

---

## Targets (Runlevels)
### **`systemctl get-default`**  
Show default target (runlevel).  
```bash
systemctl get-default          # e.g., graphical.target
```

### **`systemctl isolate`**  
Switch to a different target.  
```bash
sudo systemctl isolate multi-user.target  # Switch to CLI mode
```

---

## Troubleshooting Services
### **`systemd-analyze`**  
Analyze boot performance.  
```bash
systemd-analyze blame          # Show slowest services at boot
systemd-analyze critical-chain # Dependency chain of services
```

### **`systemctl mask`** / **`unmask`**  
Prevent a service from starting (even manually).  
```bash
sudo systemctl mask <service>  # Replace service with a symlink
sudo systemctl unmask <service>
```

### **`systemctl daemon-reload`**  
Reload systemd config after editing service files.  
```bash
sudo systemctl daemon-reload   # Required for custom service edits
```

---

## Key Service Files
- **Service unit files**: `/etc/systemd/system/` (custom) or `/usr/lib/systemd/system/` (default).  
- **Timer files**: Use `.timer` extension alongside `.service` files.  
- **Legacy init scripts**: `/etc/init.d/` (SysVinit).  

---

## Quick Reference Table
| Command                          | Purpose                          | Example                     |
|----------------------------------|----------------------------------|-----------------------------|
| `systemctl status sshd`          | Check SSH service status         | `systemctl status sshd`     |
| `sudo systemctl enable nginx`    | Enable Nginx at boot             | `sudo systemctl enable nginx`|
| `journalctl -u apache`           | View Apache logs                 | `journalctl -u apache -f`   |
| `systemctl list-dependencies`    | Show service dependencies        | `systemctl list-dependencies httpd` |
| `systemctl reboot`               | Reboot system                    | `sudo systemctl reboot`      |
| `systemctl poweroff`             | Shut down system                 | `sudo systemctl poweroff`    |

---

## Troubleshooting Tips
1. **Service Fails to Start**:  
   - Check logs: `journalctl -u <service>`.  
   - Test config: `sudo <service> configtest` (e.g., `nginx -t`).  

2. **Dependency Issues**:  
   - Use `systemctl list-dependencies <service>` to trace dependencies.  

3. **Custom Service Files**:  
   - Create unit files in `/etc/systemd/system/` and run `daemon-reload`.  

4. **Legacy Services**:  
   - For SysVinit scripts: `sudo update-rc.d <service> defaults`.  

---

**Pro Tip**: Use `systemd-cgls` to visualize the control group hierarchy.  
**WSL Note**: Many systemd commands may not work in Windows Subsystem for Linux (use `service` instead).  
Save this as `service_commands.md`! 🛠️
```
