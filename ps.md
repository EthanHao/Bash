```markdown
# Linux Process Commands Cheat Sheet

## Viewing Processes

### **`ps`**  
List running processes.  
```bash
ps aux           # Detailed list of all processes
ps -ef           # Full-format listing
ps -u <user>     # Processes owned by a user
ps --forest      # Show parent-child hierarchy
```

### **`top`** / **`htop`**  
Interactive real-time process monitoring.  
```bash
top              # Default process viewer (press `q` to quit)
htop             # Enhanced version (install with `sudo apt install htop`)
```

### **`pstree`**  
Display processes in a tree format.  
```bash
pstree -p        # Show PIDs
pstree <user>    # Processes for a specific user
```

---

## Managing Processes

### **`kill`**  
Terminate a process by PID or signal.  
```bash
kill <PID>                   # Send SIGTERM (graceful shutdown)
kill -9 <PID>                # Force kill (SIGKILL)
kill -l                      # List all signals
```

### **`killall`** / **`pkill`**  
Kill processes by name.  
```bash
killall firefox              # Terminate all Firefox instances
pkill -u <user> chrome       # Kill processes by user and name
```

### **`pgrep`**  
Find PIDs by process name.  
```bash
pgrep sshd                   # Get PID of SSH daemon
pgrep -u root                # List all root-owned processes
```

---

## Background & Foreground Jobs

### **`jobs`**  
List background jobs in the current shell.  
```bash
jobs -l          # Show job IDs and PIDs
```

### **`bg`** / **`fg`**  
Move jobs to background/foreground.  
```bash
bg %1            # Resume job ID 1 in the background
fg %2            # Bring job ID 2 to the foreground
```

### **`nohup`**  
Run a command immune to terminal hangups.  
```bash
nohup ./script.sh &  # Run script in background and ignore SIGHUP
```

---

## Process Priority

### **`nice`**  
Start a process with adjusted priority (range: -20 to 19).  
```bash
nice -n 10 ./script.sh  # Lower priority (higher "niceness")
```

### **`renice`**  
Change priority of a running process.  
```bash
renice -n 5 -p <PID>    # Set niceness to 5 for a PID
```

---

## Advanced Tools

### **`lsof`**  
List open files and associated processes.  
```bash
lsof -i :80       # Show processes using port 80
lsof -u <user>    # Files opened by a user
```

### **`strace`**  
Trace system calls and signals.  
```bash
strace -p <PID>   # Monitor a running process
```

### **`systemctl`**  
Manage systemd services (start, stop, restart).  
```bash
systemctl status sshd    # Check SSH service status
systemctl restart nginx  # Restart Nginx
```

---

## Key Metrics to Monitor
- **PID**: Process ID (unique identifier).
- **%CPU**/**%MEM**: CPU and memory usage.
- **STAT**: Process state (R=Running, S=Sleeping, Z=Zombie).
- **NI**: Niceness value (priority).

---

## Quick Reference Table

| Command            | Purpose                          | Example                     |
|--------------------|----------------------------------|-----------------------------|
| `ps aux`           | List all processes               | `ps aux \| grep nginx`      |
| `kill -9 <PID>`    | Force-kill a process             | `kill -9 1234`             |
| `htop`             | Interactive process viewer       | `htop`                      |
| `lsof -i`          | Find processes using a port      | `lsof -i :443`             |
| `systemctl`        | Manage system services           | `systemctl restart apache` |

---

## Troubleshooting Tips
1. **Zombie Processes**:  
   - Identify with `ps aux | grep 'Z'`.  
   - Parent processes must terminate them.  

2. **High CPU/Memory Usage**:  
   - Use `top` or `htop` to find resource hogs.  
   - Kill or renice problematic processes.  

3. **Service Failures**:  
   - Check logs with `journalctl -u <service>`.  

---

**Pro Tip**: Use `watch -n 1 'ps aux --sort=-%cpu'` to monitor CPU usage in real time.  
Save this as `process_commands.md`! 🐧
```
