```markdown
# Linux Network Commands Cheat Sheet

## Basic Connectivity

### **`ping`**  
Test network connectivity to a host.  
```bash
ping google.com          # Continuous ping
ping -c 4 8.8.8.8       # Send 4 packets
```

### **`ifconfig`** / **`ip`**  
Configure or view network interfaces (use `ip` for modern systems).  
```bash
ifconfig                 # Deprecated but still used
ip a                     # Show all interfaces and IPs
ip addr show eth0        # Details for a specific interface
ip route                 # Display routing table
```

### **`traceroute`** / **`mtr`**  
Trace the path packets take to a host.  
```bash
traceroute google.com    # Classic traceroute
mtr google.com           # Real-time traceroute + ping (install with `sudo apt install mtr`)
```

---

## Network Statistics

### **`netstat`**  
Display network connections, routing tables, interface stats (deprecated; use `ss`).  
```bash
netstat -tuln            # Show listening ports
netstat -r               # Display routing table
```

### **`ss`**  
Modern replacement for `netstat`.  
```bash
ss -tuln                # List all listening ports
ss -s                   # Summary statistics
ss dst 8.8.8.8          # Connections to a specific IP
```

### **`nmap`**  
Network exploration and port scanning.  
```bash
nmap 192.168.1.1        # Basic scan
nmap -p 80,443 google.com  # Scan specific ports
```

---

## DNS & Host Resolution

### **`nslookup`** / **`dig`**  
Query DNS records.  
```bash
nslookup google.com      # Basic DNS lookup
dig +short google.com    # Short answer
dig MX google.com        # Query MX records
```

### **`host`**  
Resolve hostnames to IPs and vice versa.  
```bash
host google.com
host 8.8.8.8
```

### **`whois`**  
Lookup domain registration info.  
```bash
whois google.com
```

---

## File Transfers

### **`curl`**  
Transfer data from URLs.  
```bash
curl -O https://example.com/file.zip  # Download file
curl -I https://example.com          # Show headers only
```

### **`wget`**  
Download files from the web.  
```bash
wget https://example.com/file.tar.gz
wget -c https://example.com/resume.zip  # Resume interrupted download
```

---

## Advanced Tools

### **`tcpdump`**  
Capture and analyze network traffic.  
```bash
tcpdump -i eth0          # Capture on eth0
tcpdump port 80          # Filter by port
tcpdump host 8.8.8.8     # Filter by IP
```

### **`iptables`**  
Configure firewall rules.  
```bash
iptables -L              # List rules
iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
```

### **`nc` (netcat)**  
Read/write data over TCP/UDP.  
```bash
nc -zv google.com 80     # Test port connectivity
nc -l 1234              # Listen on port 1234
```

### **`ssh`**  
Securely connect to remote servers.  
```bash
ssh user@192.168.1.100   # Basic SSH
ssh -p 2222 user@host    # Custom port
```

---

## Quick Reference Table

| Command           | Purpose                          | Example                     |
|-------------------|----------------------------------|-----------------------------|
| `ping`            | Test connectivity               | `ping -c 4 google.com`     |
| `ip a`            | Show IP addresses               | `ip addr show eth0`        |
| `ss -tuln`        | List listening ports            | `ss -tuln`                 |
| `dig`             | DNS lookup                      | `dig MX google.com`        |
| `curl`            | Transfer data via URLs          | `curl -O https://file.zip` |
| `tcpdump`         | Packet capture                  | `tcpdump port 80`          |
| `nmap`            | Port scanning                   | `nmap -p 80,443 host`      |

---

## Troubleshooting Tips
1. **No Connectivity**:  
   - Check IP and routes: `ip a` and `ip route`.  
   - Test DNS: `dig google.com`.  

2. **Port Issues**:  
   - Verify listening ports: `ss -tuln`.  
   - Test port access: `nc -zv host 80`.  

3. **DNS Resolution**:  
   - Flush DNS cache (systemd): `sudo systemd-resolve --flush-caches`.  

4. **High Latency**:  
   - Use `mtr` to diagnose packet loss/routing issues.  

---

**Pro Tip**: Use `journalctl -u NetworkManager` to debug network service errors.  
Save this as `network_commands.md`! 🚀
```
