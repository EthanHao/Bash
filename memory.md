```markdown
# Linux Memory Commands Cheat Sheet

## Real-Time Memory Monitoring

### **`free`**  
Display RAM usage (free, used, swap, buffers/cache).  
```bash
free -h       # Human-readable output (e.g., GB/MB)
free -s 5     # Refresh every 5 seconds
```

### **`top`** / **`htop`**  
Interactive process/memory viewer.  
```bash
top           # Basic process list (press `q` to quit)
htop          # Enhanced UI (install with `sudo apt install htop`)
```

### **`vmstat`**  
Report virtual memory statistics.  
```bash
vmstat 2      # Update every 2 seconds
vmstat -s     # Summary of memory usage
```

---

## Process-Specific Memory

### **`ps`**  
List processes with memory usage.  
```bash
ps aux --sort=-%mem | head  # Top memory-consuming processes
```

### **`pmap`**  
Detail memory map of a process.  
```bash
pmap -x <PID>  # Show memory breakdown for a process
```

### **`smem`**  
Advanced memory reporting (install with `sudo apt install smem`).  
```bash
smem -r -k     # Show RAM usage in KB/MB
smem -p -u     # Per-user memory consumption
```

---

## System-Wide Memory Analysis

### **`/proc/meminfo`**  
View detailed memory metrics.  
```bash
cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable"
```

### **`glances`**  
All-in-one system monitor (install with `pip install glances`).  
```bash
glances        # Shows RAM, CPU, network, and disk
```

### **`sar`**  
Historical memory stats (part of `sysstat` package).  
```bash
sar -r        # Daily memory usage report
sar -r 2 5    # 5 reports at 2-second intervals
```

---

## Advanced Tools

### **`valgrind`**  
Debug memory leaks in applications.  
```bash
valgrind --leak-check=yes ./your_program
```

### **`dmidecode`**  
Get hardware RAM details (requires `sudo`).  
```bash
sudo dmidecode --type memory  # Show installed RAM modules
```

---

## Key Metrics to Watch
- **Available Memory**: RAM ready for new processes (from `free -h`).
- **Swap Usage**: High swap usage indicates RAM pressure.
- **Cache/Buffers**: Memory used by the kernel for disk caching (non-critical).

---

## Quick Reference Table

| Command         | Purpose                          | Example                     |
|-----------------|----------------------------------|-----------------------------|
| `free -h`       | Human-readable RAM summary       | `free -h`                   |
| `htop`          | Interactive process viewer       | `htop`                      |
| `ps aux --sort` | Sort processes by memory         | `ps aux --sort=-%mem \| head` |
| `vmstat`        | Virtual memory stats             | `vmstat 2`                  |
| `smem`          | Detailed memory reports          | `smem -k`                   |

---

## Troubleshooting Tips
1. **High Memory Usage**:  
   - Use `top` or `ps` to identify rogue processes.  
   - Kill processes with `kill -9 <PID>` if needed.  

2. **Memory Leaks**:  
   - Profile applications with `valgrind`.  

3. **Swap Optimization**:  
   - Reduce swappiness:  
     ```bash
     sudo sysctl vm.swappiness=10  # Temporary change
     ```

---

**Pro Tip**: Automate monitoring with `watch` (e.g., `watch -n 2 free -h`).  
Save this as `memory_commands.md`! 🚀
```
