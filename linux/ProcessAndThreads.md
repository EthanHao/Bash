Here's a practical guide to inspecting process and thread information in `/proc` with examples:

### 1. **Process Information in `/proc`**
Each process has a directory `/proc/<PID>` containing runtime details.

**Key Files:**
```bash
/proc/12345/
├── cmdline     # Full command line
├── comm        # Command name
├── status      # Process status summary
├── stat        # Detailed process stats
├── exe         # Symbolic link to executable
├── cwd         # Symbolic link to current directory
└── fd/         # Directory of open file descriptors
```

**Essential Checks:**
```bash
# Find PID of a process
pidof firefox

# View command line
cat /proc/12345/cmdline | tr '\0' ' '; echo

# View process status
cat /proc/12345/status

# View open files
ls -l /proc/12345/fd
```

**Example Output (`/proc/12345/status`):**
```
Name:   chrome
State:  S (sleeping)
Tgid:   12345       # Thread group ID (PID)
Pid:    12345       # Process ID (same as Tgid for main thread)
PPid:   5678        # Parent PID
Threads: 47         # Number of threads
UID:    1000        # Real/Effective/Saved UIDs
Gid:    1000        # Real/Effective/Saved GIDs
FDSize: 256         # File descriptor slots
```

---

### 2. **Thread Information in `/proc`**
Each thread appears as:
- `/proc/<PID>/task/<TID>` directory
- Threads share the same PID but have unique TIDs

**Key Checks:**
```bash
# List all threads in a process
ls /proc/12345/task

# View thread status
cat /proc/12345/task/12346/status

# View thread stack
cat /proc/12345/task/12346/stack
```

**Example Output (`/proc/12345/task/12346/status`):**
```
Name:   chrome
State:  S (sleeping)
Tgid:   12345       # Parent PID
Pid:    12346       # Thread ID
PPid:   5678        
Seccomp: 2          # Security mode
voluntary_ctxt_switches: 1241
nonvoluntary_ctxt_switches: 57
```

---

### 3. **Practical Inspection Script**
Run this to see real-time process/thread details:

```bash
#!/bin/bash

# Create demo multi-threaded program
cat > thread_demo.c <<EOF
#include <pthread.h>
#include <unistd.h>
void* thread_func(void* arg) {
    sleep(300);  // Keep threads alive
    return NULL;
}
int main() {
    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_func, NULL);
    pthread_create(&t2, NULL, thread_func, NULL);
    sleep(300);  // Keep process alive
    return 0;
}
EOF

gcc thread_demo.c -o thread_demo -pthread
./thread_demo &
DEMO_PID=$!

echo "Process PID: $DEMO_PID"
echo -e "\n=== Process cmdline ==="
cat /proc/$DEMO_PID/cmdline | tr '\0' ' '; echo

echo -e "\n=== Thread IDs ==="
ls /proc/$DEMO_PID/task

echo -e "\n=== Main Thread Status (PID $DEMO_PID) ==="
grep 'Name\|State\|Tgid\|Pid\|Threads' /proc/$DEMO_PID/status

echo -e "\n=== Child Thread Status ==="
for TID in $(ls /proc/$DEMO_PID/task | grep -v $DEMO_PID); do
    echo "Thread TID: $TID"
    grep 'Name\|State\|Tgid\|Pid' /proc/$DEMO_PID/task/$TID/status
    echo
done

# Cleanup
kill $DEMO_PID
rm thread_demo thread_demo.c
```

**Sample Output:**
```
Process PID: 7890

=== Process cmdline ===
./thread_demo 

=== Thread IDs ===
7890 7891 7892 7893

=== Main Thread Status (PID 7890) ===
Name:   thread_demo
State:  S (sleeping)
Tgid:   7890
Pid:    7890
Threads: 4

=== Child Thread Status ===
Thread TID: 7891
Name:   thread_demo
State:  S (sleeping)
Tgid:   7890
Pid:    7891

Thread TID: 7892
Name:   thread_demo
State:  S (sleeping)
Tgid:   7890
Pid:    7892
```

---

### 4. **Key Observations**
1. **PID vs TID**:
   - All threads share same `Tgid` (Thread Group ID = PID)
   - Each thread has unique `Pid` (Thread ID)

2. **Directory Structure**:
   ```
   /proc/7890/          # Process directory
     ├── task/7890/     # Main thread
     ├── task/7891/     # Child thread
     └── task/7892/     # Child thread
   ```

3. **Thread-Specific Files**:
   - Each thread has its own `stat`, `status`, `io`, `sched`, and `syscall` files
   - Stack traces are per-thread (`/proc/<PID>/task/<TID>/stack`)

4. **Performance Metrics**:
   - CPU usage: `/proc/<PID>/task/<TID>/stat`
   - Context switches: `/proc/<PID>/task/<TID>/status`
   - Scheduling info: `/proc/<PID>/task/<TID>/sched`

---

### 5. **Quick Reference Commands**
```bash
# Show all processes
ls /proc | grep -E '^[0-9]+$'

# Count threads in process
cat /proc/<PID>/status | grep Threads

# View thread CPU usage
cat /proc/<PID>/task/<TID>/stat | awk '{print $14+$15}'

# View open files per thread
ls -l /proc/<PID>/task/<TID>/fd

# Map threads to CPU cores
ps -T -p <PID> -o pid,tid,psr,cmd
```

The `/proc` filesystem provides direct insight into kernel-level process and thread management, showing how Linux implements threads as schedulable entities (tasks) sharing the same process context.
