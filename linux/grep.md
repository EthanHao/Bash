Here's a concise **`grep` tutorial** covering essential usage for searching and filtering text in files and streams:

---

### **1. Basic Syntax**
```bash
grep [options] pattern [file...]
```

---

### **2. Basic Examples**
#### **Search for a string in a file**
```bash
grep "error" logfile.txt
```

#### **Case-insensitive search**
```bash
grep -i "warning" logfile.txt
```

#### **Search recursively in directories**
```bash
grep -r "TODO" ~/projects/  # Search all files under ~/projects
```

#### **Search in multiple files**
```bash
grep "404" access.log error.log
```

---

### **3. Regular Expressions**
#### **Basic regex**
```bash
grep "^2023" dates.txt        # Lines starting with "2023"
grep "\.html$" files.txt      # Lines ending with ".html"
grep "[Aa]pple" fruits.txt    # Match "Apple" or "apple"
```

#### **Extended regex (supports `+`, `|`, `()` etc.)**
```bash
grep -E "(error|warning)" log.txt  # Match "error" OR "warning"
grep -E "[0-9]{3}-[0-9]{4}" data  # Match phone numbers (###-####)
```

---

### **4. Common Options**
| Option | Description                                      |
|--------|--------------------------------------------------|
| `-i`   | Case-insensitive search                          |
| `-v`   | Invert match (show lines NOT containing pattern) |
| `-n`   | Show line numbers                                |
| `-c`   | Count matches instead of showing lines           |
| `-l`   | List filenames with matches                      |
| `-w`   | Match whole words only                           |
| `-A 3` | Show 3 lines after the match                     |
| `-B 2` | Show 2 lines before the match                    |
| `-C 5` | Show 5 lines around the match                    |

---

### **5. Practical Examples**
#### **Find processes containing "nginx"**
```bash
ps aux | grep nginx
```

#### **Count occurrences of "success" in a file**
```bash
grep -c "success" results.csv
```

#### **Search for multiple patterns**
```bash
grep -e "error" -e "critical" log.txt
```

#### **Find empty lines**
```bash
grep "^$" file.txt
```

#### **Exclude directory from recursive search**
```bash
grep -r --exclude-dir=node_modules "TODO" .
```

---

### **6. Advanced Usage**
#### **Search binary files as text**
```bash
grep -a "text" binaryfile.bin
```

#### **Use Perl-compatible regex (PCRE)**
```bash
grep -P "\d{3}-\d{4}" contacts.txt  # Match ###-#### phone numbers
```

#### **Highlight matches**
```bash
grep --color=auto "pattern" file.txt
```

#### **Search compressed files**
```bash
zgrep "error" access.log.gz  # Works with gzip files
```

---

### **7. Combining with Other Commands**
#### **Find files containing "password"**
```bash
find . -type f -exec grep -l "password" {} +
```

#### **Search in `tar` archive**
```bash
tar xzf file.tar.gz -O | grep "pattern"
```

#### **Monitor log files in real-time**
```bash
tail -f app.log | grep "ERROR"
```

---

### **8. Tips**
1. **Escape special characters** like `$`, `*`, or `?` with `\`:
   ```bash
   grep "\$100" prices.txt
   ```

2. **Search for fixed strings** (disables regex):
   ```bash
   grep -F "*.example.com" config.txt
   ```

3. **Speed up large files** with `--mmap` (memory-mapped I/O).

4. **Exclude files**:
   ```bash
   grep -r --exclude="*.tmp" "pattern" .
   ```

---

### **9. Common Use Cases**
- **Debugging logs**: `grep -C 5 "Exception" app.log`
- **Data filtering**: `csvtool namedcol "Email" data.csv | grep "@company.com"`
- **Code maintenance**: `grep -rnw '/src/' -e 'deprecated_function'`

---

### **Alternatives**
- `ag` (The Silver Searcher): Faster recursive searches
- `rg` (ripgrep): Modern grep replacement with better performance
- `ack`: Optimized for code searching

---

**Pro Tip**: Combine `grep` with `cut`, `sort`, and `uniq` for powerful text processing:
```bash
grep "GET /api/" access.log | cut -d' ' -f1 | sort | uniq -c
```

This shows how many times each IP accessed `/api/` endpoints.
