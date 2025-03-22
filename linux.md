Here’s a **complete, beginner-friendly Linux guide** with all 11 sections in one Markdown file:

```markdown
# Linux Essentials Guide

## Table of Contents
1. [Basic Navigation](#1-basic-navigation)  
2. [File Operations](#2-file-operations)  
3. [Text Editing (Nano)](#3-text-editing-nano)  
4. [Permissions & Ownership](#4-permissions--ownership)  
5. [Package Management](#5-package-management)  
6. [Process Management](#6-process-management)  
7. [Networking Basics](#7-networking-basics)  
8. [User Management](#8-user-management)  
9. [Help & Documentation](#9-help--documentation)  
10. [Basic Shell Scripting](#10-basic-shell-scripting)  
11. [Archive/Compress Files](#11-archivecompress-files)  

---

## 1. Basic Navigation <a name="1-basic-navigation"></a>
```bash
pwd                 # Show current directory
ls                  # List files
ls -lha             # Detailed list (hidden files, sizes)
cd Documents        # Enter folder
cd ..               # Go back one level
cd ~                # Return to home directory
```

**[▲ Back to Top](#table-of-contents)**

---

## 2. File Operations <a name="2-file-operations"></a>
### Create/Delete
```bash
touch file.txt      # Create file
mkdir folder        # Create directory
rm file.txt        # Delete file
rm -rf folder/     # Force-delete directory
```

### Copy/Move
```bash
cp file.txt backup/ # Copy file
cp -r dir1/ dir2/  # Copy directory
mv old.txt new.txt # Rename file
mv file.txt ~/      # Move to home
```

### View Files
```bash
cat file.txt       # Display entire file
less file.txt      # Scrollable view (press Q to quit)
head -n 5 file.txt # Show first 5 lines
tail -f log.log   # Watch real-time updates
```

**[▲ Back to Top](#table-of-contents)**

---

## 3. Text Editing (Nano) <a name="3-text-editing-nano"></a>
```bash
nano file.txt      # Open/create file
```
- **Ctrl+O**: Save  
- **Ctrl+X**: Exit  
- **Ctrl+K**: Cut line  
- **Ctrl+U**: Paste  

**[▲ Back to Top](#table-of-contents)**

---

## 4. Permissions & Ownership <a name="4-permissions--ownership"></a>
### Change Permissions
```bash
chmod 755 script.sh  # rwx for owner, rx others
chmod +x script.sh   # Make executable
```

### Change Ownership
```bash
sudo chown user:group file.txt
```

**[▲ Back to Top](#table-of-contents)**

---

## 5. Package Management <a name="5-package-management"></a>
### Debian/Ubuntu (apt)
```bash
sudo apt update        # Refresh packages
sudo apt install nano  # Install
sudo apt remove nano   # Remove
```

### Fedora/CentOS (dnf/yum)
```bash
sudo dnf install nano
sudo yum remove nano
```

**[▲ Back to Top](#table-of-contents)**

---

## 6. Process Management <a name="6-process-management"></a>
```bash
ps aux               # List all processes
top                  # Live monitoring
kill 1234           # Terminate PID 1234
killall firefox     # Kill all Firefox instances
```

**[▲ Back to Top](#table-of-contents)**

---

## 7. Networking Basics <a name="7-networking-basics"></a>
```bash
ping google.com     # Test connection
ip a               # Show IP addresses
curl ifconfig.me   # Get public IP
wget https://example.com/file.zip  # Download
```

**[▲ Back to Top](#table-of-contents)**

---

## 8. User Management <a name="8-user-management"></a>
```bash
sudo useradd john   # Create user
sudo passwd john    # Set password
sudo usermod -aG sudo john  # Grant sudo
whoami             # Show current user
```

**[▲ Back to Top](#table-of-contents)**

---

## 9. Help & Documentation <a name="9-help--documentation"></a>
```bash
man ls             # Full manual
ls --help          # Quick help
whatis chmod       # Brief description
```

**[▲ Back to Top](#table-of-contents)**

---

## 10. Basic Shell Scripting <a name="10-basic-shell-scripting"></a>
Create `hello.sh`:
```bash
#!/bin/bash
echo "Hello World!"
```
```bash
chmod +x hello.sh  # Make executable
./hello.sh        # Run script
```

**[▲ Back to Top](#table-of-contents)**

---

## 11. Archive/Compress Files <a name="11-archivecompress-files"></a>
```bash
# TAR.GZ
tar -czvf archive.tar.gz folder/  # Create
tar -xzvf archive.tar.gz         # Extract

# ZIP
zip archive.zip file.txt
unzip archive.zip
```

**[▲ Back to Top](#table-of-contents)**

---

## Troubleshooting Tips
- **Permission denied?** Use `sudo` or check permissions with `ls -l`.  
- **Command not found?** Install package or check spelling.  
- **Frozen terminal?** Press `Ctrl+C` to stop.  

## Learning Resources
- [Linux Journey](https://linuxjourney.com/) (Free tutorials)  
- [ExplainShell](https://explainshell.com/) (Command breakdown)  

🐧 **Practice these in a terminal! Save as `linux_guide.md` for reference.**
```

**How to Use**:  
1. Copy **all** content above  
2. Paste into a text editor (VS Code, Notepad++)  
3. Save as `linux_guide.md`  

Features:  
- Clickable table of contents  
- Clean formatting for readability  
- All essential commands in one place
