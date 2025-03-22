```markdown
# Bash File Commands Cheat Sheet

## Navigation
- **`pwd`**  
  Show current directory path.  
  ```bash
  pwd
  ```

- **`ls`**  
  List directory contents.  
  ```bash
  ls          # Basic list
  ls -l       # Detailed view
  ls -a       # Include hidden files
  ```

- **`cd`**  
  Change directory.  
  ```bash
  cd ~        # Go to home
  cd ..       # Move up
  ```

## File Operations
### Create/View
- **`touch`**  
  Create empty file:  
  ```bash
  touch file.txt
  ```

- **`cat`**  
  Display file content:  
  ```bash
  cat file.txt
  ```

- **`head`/`tail`**  
  View first/last lines:  
  ```bash
  head -n 5 file.txt
  tail -f log.log
  ```

### Edit
- **`nano`/`vim`**  
  Text editors:  
  ```bash
  nano file.txt
  ```

### Copy/Move
- **`cp`**  
  Copy files/dirs:  
  ```bash
  cp file.txt backup/
  cp -r dir1 dir2
  ```

- **`mv`**  
  Move/rename:  
  ```bash
  mv old.txt new.txt
  ```

### Delete
- **`rm`**  
  Remove files/dirs:  
  ```bash
  rm file.txt
  rm -rf dir/
  ```

## Permissions
- **`chmod`**  
  Change permissions:  
  ```bash
  chmod 755 script.sh
  ```

- **`chown`**  
  Change ownership:  
  ```bash
  sudo chown user:group file.txt
  ```

## Search
- **`find`**  
  Search files:  
  ```bash
  find . -name "*.txt"
  ```

- **`grep`**  
  Search text:  
  ```bash
  grep "error" log.txt
  ```

## Compression
- **`tar`**  
  Archive files:  
  ```bash
  tar -czvf archive.tar.gz dir/
  tar -xzvf archive.tar.gz
  ```

- **`zip`/`unzip`**  
  ZIP archives:  
  ```bash
  zip files.zip file1 file2
  unzip files.zip
  ```

## Links
- **`ln`**  
  Create symbolic link:  
  ```bash
  ln -s /path/to/file link
  ```

## Wildcards & Redirection
- **Wildcards**:  
  ```bash
  cp *.txt backups/
  ```

- **Redirection**:  
  ```bash
  echo "Hello" > file.txt   # Overwrite
  echo "World" >> file.txt  # Append
  ```

---
*Save this as `bash_commands.md` and use it offline!*
```
