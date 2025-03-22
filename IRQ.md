```markdown
# Linux Interrupt Commands Cheat Sheet

## Viewing Hardware Interrupts

### **`cat /proc/interrupts`**  
List interrupt (IRQ) counts per CPU core.  
```bash
cat /proc/interrupts     # Real-time interrupt counters
watch -n 1 'cat /proc/interrupts'  # Refresh every second
```

### **`mpstat`**  
Monitor CPU usage including interrupt stats (requires `sysstat`).  
```bash
mpstat -P ALL 2         # Report every 2 seconds, all CPUs
mpstat -I CPU           # Show CPU-specific interrupt stats
```

### **`perf`**  
Advanced performance analysis (includes interrupts).  
```bash
sudo perf top -e irq:irq_handler_entry  # Trace interrupt handlers
```

---

## Analyzing Interrupts

### **`irqbalance`**  
Manage IRQ distribution across CPUs (for multi-core systems).  
```bash
sudo systemctl status irqbalance   # Check if running
sudo service irqbalance stop       # Temporarily disable
```

### **`turbostat`**  
Monitor CPU states, including interrupts (Intel/AMD CPUs).  
```bash
sudo turbostat --show IRQ,PkgWatt  # Requires root
```

### **`lscpu`**  
View CPU architecture details (cores, sockets).  
```bash
lscpu                   # Identify CPU topology for IRQ affinity
```

---

## Interrupt Affinity (IRQ Balancing)

### **`/proc/irq/<IRQ>/smp_affinity`**  
Set CPU affinity for specific interrupts.  
```bash
echo 4 > /proc/irq/128/smp_affinity  # Bind IRQ 128 to CPU 2 (mask 0b100)
```

### **`taskset`**  
Bind processes/IRQs to specific CPUs.  
```bash
taskset -cp 0,1 <PID>   # Restrict process to CPUs 0 and 1
```

---

## Kernel-Level Tools

### **`ftrace`**  
Kernel function tracer (includes IRQ events).  
```bash
sudo trace-cmd record -e irq -o trace.dat  # Capture IRQ events
trace-cmd report trace.dat
```

### **`dmesg`**  
Check kernel logs for interrupt errors.  
```bash
dmesg | grep -i irq     # Filter IRQ-related kernel messages
```

---

## Quick Reference Table

| Command/Tool          | Purpose                          | Example                     |
|-----------------------|----------------------------------|-----------------------------|
| `cat /proc/interrupts`| View IRQ distribution            | `watch -n 1 'cat /proc/interrupts'` |
| `mpstat -I SUM`       | Total interrupt rate             | `mpstat -I SUM 2`          |
| `perf`                | Trace interrupt handlers         | `sudo perf top -e irq:*`   |
| `smp_affinity`        | Bind IRQ to CPU                  | `echo 8 > /proc/irq/42/smp_affinity` |
| `lspci -vv`           | Check device IRQ assignments     | `lspci -vv \| grep IRQ`     |

---

## Troubleshooting Tips
1. **High Interrupt Load**:  
   - Identify top IRQ sources via `/proc/interrupts`.  
   - Check NICs, GPUs, or storage controllers (e.g., `lspci` for device IDs).  

2. **IRQ Conflicts**:  
   - Use `dmesg` to check for kernel errors like `IRQ XX: nobody cared`.  

3. **Balancing Interrupts**:  
   - Enable `irqbalance` service:  
     ```bash
     sudo systemctl enable --now irqbalance
     ```
   - Manually assign IRQ affinity for critical devices.  

4. **Kernel Drivers**:  
   - Update drivers (e.g., NIC firmware) if interrupts are spiking.  

---

## Key Metrics
- **IRQ Rate**: Interrupts per second (use `mpstat`).  
- **CPU SoftIRQ**: Software interrupts (`cat /proc/softirqs`).  
- **Device-Specific IRQs**: Correlate `/proc/interrupts` with `lspci`.  

---

**Pro Tip**: Use `htop` (F2 → Columns → IRQ) to see interrupt usage per process.  
Save this as `interrupt_commands.md`! ⚡

**WSL Note**: Hardware interrupt commands (e.g., `/proc/interrupts`) may not work in WSL.  
**Requires Root**: Many commands need `sudo` or root access.  
```
