Here's how to use **`jq`** (a lightweight JSON processor) to parse and manipulate JSON files:

---

### **Basic Syntax**
```bash
jq [options] '<filter>' <file.json>
```

---

### **Common Operations**

#### **1. Pretty-Print JSON**
```bash
jq . file.json       # Format JSON with indentation
```

#### **2. Select a Field**
```bash
jq '.key' file.json            # Get value of a top-level key
jq '.parent.child' file.json   # Nested key
```

#### **3. Iterate Over Arrays**
```bash
jq '.[]' file.json             # Iterate all array elements
jq '.users[]' file.json        # Iterate "users" array
```

#### **4. Filter with Conditions**
```bash
jq '.[] | select(.age > 30)' file.json   # Filter array elements
jq '.users[] | select(.active == true)' file.json
```

#### **5. Combine Filters**
```bash
jq '.users[] | {name: .name, email: .email}' file.json
```

#### **6. Modify Output**
```bash
jq -r '.name' file.json       # Raw output (no quotes)
jq -c '.' file.json           # Compact JSON (no indentation)
```

---

### **Examples**

#### **Example JSON File (`data.json`)**:
```json
{
  "users": [
    { "id": 1, "name": "Alice", "active": true },
    { "id": 2, "name": "Bob", "active": false }
  ]
}
```

#### **1. Extract All User Names**
```bash
jq '.users[].name' data.json
# Output:
# "Alice"
# "Bob"
```

#### **2. Filter Active Users**
```bash
jq '.users[] | select(.active == true)' data.json
# Output:
# { "id": 1, "name": "Alice", "active": true }
```

#### **3. Create Custom Objects**
```bash
jq '.users[] | {username: .name, status: (.active | if . then "active" else "inactive" end)}' data.json
# Output:
# { "username": "Alice", "status": "active" }
# { "username": "Bob", "status": "inactive" }
```

---

### **Useful Options**
| Option | Description                      |
|--------|----------------------------------|
| `-r`   | Raw output (no JSON quotes)      |
| `-c`   | Compact output (no pretty-print) |
| `-s`   | Read entire input as a single array |

---

### **Advanced Usage**
#### **1. Combine Multiple Filters**
```bash
jq '.users | length' data.json      # Count users
jq 'map(.name) | sort' data.json    # Sort names
```

#### **2. Modify JSON**
```bash
jq '.users[0].name = "Charlie"' data.json  # Change a value
```

#### **3. Read from STDIN**
```bash
curl https://api.example.com/data | jq '.results'
```

---

### **Troubleshooting**
- **Syntax Errors**: Use `jq --debug-dump-disasm` to debug filters.
- **Invalid JSON**: Validate with `jq empty file.json` (errors will show issues).

---

For more, see the [jq Manual](https://stedolan.github.io/jq/manual/). 🚀
