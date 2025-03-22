Here's a concise **cURL tutorial** covering essential commands and use cases for interacting with web services, APIs, and files via the command line:

---

### **1. Installation**
- **Linux/macOS**: Pre-installed (check with `curl --version`).
- **Windows**: Download from [curl.se](https://curl.se/windows/) or use WSL.

---

### **2. Basic Usage**
#### **Fetch a URL**
```bash
curl https://example.com
```
Outputs the HTML/content of the URL to your terminal.

---

### **3. Save Output to File**
```bash
curl -o filename.txt https://example.com
```
- `-o`: Saves content to `filename.txt`.

---

### **4. Follow Redirects**
```bash
curl -L https://bit.ly/short-url
```
- `-L`: Follows HTTP redirects (e.g., shortened URLs).

---

### **5. Verbose Mode**
```bash
curl -v https://example.com
```
- `-v`: Shows headers, SSL handshake, and connection details.

---

### **6. HTTP Headers**
#### **Send Custom Headers**
```bash
curl -H "User-Agent: MyApp" -H "Authorization: Bearer token" https://api.example.com
```
- `-H`: Adds a header to the request.

#### **View Response Headers**
```bash
curl -i https://example.com  # Includes headers in output
curl -I https://example.com  # Shows ONLY headers (HEAD request)
```

---

### **7. POST Requests**
#### **Send Form Data**
```bash
curl -X POST -d "name=John&age=30" https://api.example.com/submit
```
- `-X POST`: Specifies the HTTP method.
- `-d`: Sends data in the request body.

#### **Send JSON Data**
```bash
curl -X POST -H "Content-Type: application/json" -d '{"name": "John"}' https://api.example.com/data
```

---

### **8. Authentication**
#### **Basic Auth**
```bash
curl -u username:password https://api.example.com/secure
```

---

### **9. File Upload**
```bash
curl -F "file=@/path/to/file.jpg" https://api.example.com/upload
```
- `-F`: Uploads a file as multipart/form-data.

---

### **10. Download Files**
```bash
curl -O https://example.com/file.zip  # Saves with original filename
curl -o customname.zip https://example.com/file.zip
```

---

### **11. Resume a Failed Download**
```bash
curl -C - -O https://example.com/largefile.zip
```
- `-C -`: Resumes from where the download left off.

---

### **12. Limit Download Speed**
```bash
curl --limit-rate 200K -O https://example.com/largefile.zip
```
- Limits speed to 200 KB/s.

---

### **13. Use Proxies**
```bash
curl -x http://proxy-server:port https://example.com
```

---

### **14. Handle Cookies**
```bash
curl -c cookies.txt https://example.com/login  # Save cookies
curl -b cookies.txt https://example.com/dashboard  # Send cookies
```

---

### **Practical Examples**
1. **Check Your Public IP**:
   ```bash
   curl ifconfig.me
   ```

2. **Download an Image**:
   ```bash
   curl -o image.jpg https://example.com/image.jpg
   ```

3. **Test a REST API**:
   ```bash
   curl -X GET "https://api.github.com/users/octocat"
   ```

4. **Save Cookies and Reuse**:
   ```bash
   curl -c cookies.txt https://example.com/login -d "user=admin&pass=123"
   curl -b cookies.txt https://example.com/profile
   ```

---

### **Common Options**
| Short Flag | Long Flag       | Description                          |
|------------|-----------------|--------------------------------------|
| `-o`       | `--output`      | Save output to a file                |
| `-L`       | `--location`    | Follow redirects                     |
| `-H`       | `--header`      | Add a request header                 |
| `-d`       | `--data`        | Send POST data                       |
| `-u`       | `--user`        | Add username/password for auth       |
| `-x`       | `--proxy`       | Use a proxy server                   |
| `-v`       | `--verbose`     | Show detailed logs                   |
| `-s`       | `--silent`      | Hide progress/error messages         |
| `-k`       | `--insecure`    | Bypass SSL certificate checks        |

---

### **Tips**
- Use `--fail` to exit with an error code on HTTP errors:
  ```bash
  curl --fail -o /dev/null https://example.com
  ```
- Combine with `jq` to parse JSON responses:
  ```bash
  curl https://api.example.com/data | jq '.results[0].name'
  ```
- Avoid exposing secrets in command history (use environment variables for sensitive data).

---

For more details, check the official docs:  
📖 [curl Manual](https://curl.se/docs/manual.html)
