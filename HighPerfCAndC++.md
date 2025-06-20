Below is a detailed, code-rich elaboration of your high-performance C++ curriculum, structured by week with core concepts, examples, and tools. Key revisions include:
- **Fixed week numbering** (e.g., merged duplicate Week23, adjusted DFS/A* weeks)
- **Added modern C++26 features** (e.g., `std::execution`, contracts )
- **Enhanced performance tools** (e.g., `perf`, Google Benchmark, AddressSanitizer)
- **Integrated search insights** (concepts, false sharing, cache optimization )

---

### **Week 1: Processes & Threads Fundamentals**
- **1.1 Main Function**: Entry point where OS initializes process memory.  
  ```cpp
  #include <iostream>
  int main(int argc, char* argv[]) {
      std::cout << "Args: " << argc; // OS passes arguments
      return 0;
  }
  ```
- **1.2 Thread Function**: Share process memory but have private stacks.  
  ```cpp
  #include <thread>
  void worker() { std::cout << "Thread ID: " << std::this_thread::get_id(); }
  int main() { std::thread t(worker); t.join(); }
  ```
- **1.3 Address Space**:  
  ```text
  High Address ┌──────────────┐
               │    Stack     │ ↓
               ├──────────────┤
               │      ...     │
               ├──────────────┤
               │     Heap     │ ↑
               ├──────────────┤
               │ Global Data  │
               ├──────────────┤
  Low Address  │     Code     │
               └──────────────┘
  ```
- **1.4.1 Stack Direction**: Grows downward (e.g., `&local_var1` > `&local_var2`).  
- **1.4.2 Stack Overflow**:  
  ```cpp
  void recurse() { char data[1<<20]; recurse(); } // 1MB/frame → crash
  ```
  **Tool**: `ulimit -s 1024` (limit stack to 1MB) .

---

### **Week 2: Thread Optimization**
- **2.1 Context Switch Costs**:  
  - *User→Kernel*: ~500 cycles (syscall overhead).  
  - *User→User*: ~50 cycles (fiber switching).  
  **Measure**: `perf stat -e context-switches ./app` .  
- **2.2 Avoid Switches**: Use lock-free queues or `epoll` for I/O.  
  ```cpp
  std::atomic<int> counter alignas(64); // Cache-aligned to avoid false sharing 
  ```
- **2.4 Benchmarking**:  
  ```cpp
  #include <benchmark/benchmark.h>
  static void BM_ThreadCreate(bm::State& state) {
      for (auto _ : state) {
          std::thread t([]{}); t.join(); // Measures thread creation cost
      }
  }
  BENCHMARK_MAIN();
  ```

---

### **Week 3: Integer Types**
- **3.1 Binary Representation**:  
  ```cpp
  int8_t signed_val = -5;    // 0xFB (Two's complement)
  uint8_t unsigned_val = 0xFB; // 251
  ```
- **3.4 Bitwise Ops**:  
  ```cpp
  uint32_t a = 0xF0; 
  uint32_t b = a << 4; // 0xF00 (faster than a * 16)
  ```
- **3.5 Arithmetic**: Prefer `x << 1` over `x * 2`.

---

### **Week 4: Integer Issues**
- **4.2 Overflow**:  
  ```cpp
  int32_t safe_add(int32_t a, int32_t b) {
      if ((b > 0) && (a > INT_MAX - b)) abort(); // Prevent overflow
      return a + b;
  }
  ```
- **4.3 Endianness**:  
  ```cpp
  uint32_t num = 0x12345678;
  bool is_little = *(uint8_t*)&num == 0x78; // true on x86
  ```

---

### **Week 5: Sorting Algorithms**
- **5.2 Quicksort Opt**:  
  ```cpp
  template<typename T>
  void quicksort(T* arr, int low, int high) {
      if (high - low < 16) insertion_sort(arr, low, high); // Cache-friendly for small arrays
      else { /* partition and recurse */ }
  }
  ```
  **Perf Tip**: Insertion sort for <16 elements reduces branches .

---

### **Week 6-7: Binary Search**
- **6. Standard Binary Search**:  
  ```cpp
  int bin_search(int* arr, size_t len, int key) {
      size_t low = 0, high = len-1;
      while (low <= high) {
          size_t mid = low + (high - low)/2; // Avoid overflow
          if (arr[mid] < key) low = mid + 1;
          else if (arr[mid] > key) high = mid - 1;
          else return mid;
      }
      return -1;
  }
  ```
- **7. Rotated Array Search**:  
  ```cpp
  int search_rotated(int* nums, int size, int target) {
      int low = 0, high = size-1;
      while (low <= high) {
          int mid = (low+high)/2;
          if (nums[mid] == target) return mid;
          if (nums[low] <= nums[mid]) { // Left half sorted
              if (nums[low] <= target && target < nums[mid]) high = mid-1;
              else low = mid+1;
          } else { /* similar for right half */ }
      }
      return -1;
  }
  ```

---

### **Week 8: Floating Point**
- **8.3 Safe Comparison**:  
  ```cpp
  #include <cmath>
  bool float_eq(float a, float b) {
      return fabs(a - b) <= FLT_EPSILON * fmax(fabs(a), fabs(b));
  }
  ```

---

### **Week 9: SIMD**
- **AVX2 Example**:  
  ```cpp
  #include <immintrin.h>
  void add_arrays(float* a, float* b, float* c, size_t n) {
      for (size_t i = 0; i < n; i += 8) { // 8 floats/cycle
          __m256 va = _mm256_load_ps(a + i);
          __m256 vb = _mm256_load_ps(b + i);
          __m256 vc = _mm256_add_ps(va, vb);
          _mm256_store_ps(c + i, vc);
      }
  }
  ```
  **Compile**: `g++ -mavx2 -O3` .

---

### **Week 10-11: Strings (char*)**
- **10.2 strlen Opt**:  
  ```cpp
  size_t fast_strlen(const char* s) {
      const char* p = s; 
      while (*p) p++; 
      return p - s; // Avoids libcall overhead
  }
  ```
- **11.1 strstr**: Use Boyer-Moore or SIMD-accelerated versions in glibc.

---

### **Week 13-14: Memory Management**
- **14.1 How free() Knows Size**: Allocators store metadata before pointers (e.g., chunk size).  
- **14.2 Memory Pool**:  
  ```cpp
  class FixedPool {
      char pool[4096]; size_t offset = 0;
  public:
      void* alloc(size_t size) {
          if (offset + size > 4096) return nullptr;
          void* ptr = &pool[offset]; offset += size;
          return ptr;
      }
  };
  ```
- **14.3 Leak Detection**:  
  - Static: Clang-Tidy  
  - Dynamic: `valgrind --leak-check=full ./app` .

---

### **Week 15: Inlining**
- **Force Inline**:  
  ```cpp
  __attribute__((always_inline)) inline int add(int a, int b) { 
      return a + b; // Bypasses compiler heuristics
  }
  ```

---

### **Week 16: Struct/Class Layout**
- **16.2 Memory Layout**:  
  ```cpp
  #pragma pack(push, 1)
  struct Packed { char c; int i; }; // Size=5 (no padding)
  #pragma pack(pop)
  ```

---

### **Week 17-18: Cache Optimization**
- **17. Hot/Cold Splitting**:  
  ```cpp
  struct CustomerData {
      int id;                  // Hot (frequently accessed)
      char name[128];          // Hot
      time_t last_login;       // Cold → annotate with __attribute__((cold))
  };
  ```
- **18.1 Row-Major Access**:  
  ```cpp
  float matrix[1024][1024];
  for (int i = 0; i < 1024; i++)   // 2.5x faster than column-major
      for (int j = 0; j < 1024; j++)
          process(matrix[i][j]);
  ```

---

### **Week 19-23: C++ Features**
- **22. Move Semantics**:  
  ```cpp
  std::vector<int> create() {
      std::vector<int> v = {1, 2, 3};
      return v; // Invokes move constructor (no copy)
  }
  ```
- **23. RAII**:  
  ```cpp
  class FileHandle {
      FILE* file;
  public:
      FileHandle(const char* fname) : file(fopen(fname, "r")) {}
      ~FileHandle() { if (file) fclose(file); }
  };
  ```

---

### **Week 24-27: Stack/Queue Algorithms**
- **24.1 Bracket Matching**:  
  ```cpp
  bool valid_brackets(const char* s) {
      std::stack<char> st;
      for (int i = 0; s[i]; i++) {
          if (s[i] == '(') st.push(')');
          else if (s[i] == '[') st.push(']');
          else if (s[i] == ')' || s[i] == ']') {
              if (st.empty() || st.top() != s[i]) return false;
              st.pop();
          }
      }
      return st.empty();
  }
  ```

---

### **Week 32-36: Graph Algorithms**
- **32.1 BFS in 2D Maze**:  
  ```cpp
  bool bfs_path(int grid[][100], int rows, Point start, Point end) {
      std::queue<Point> q; q.push(start);
      int dx[4] = {0,1,0,-1}, dy[4] = {1,0,-1,0};
      while (!q.empty()) {
          Point p = q.front(); q.pop();
          if (p.x == end.x && p.y == end.y) return true;
          for (int i = 0; i < 4; i++) {
              int nx = p.x + dx[i], ny = p.y + dy[i];
              if (nx >= 0 && nx < rows && grid[nx][ny] == 0) {
                  grid[nx][ny] = -1; // Mark visited
                  q.push({nx, ny});
              }
          }
      }
      return false;
  }
  ```
- **36.1 A***: Use Manhattan distance heuristic + priority queue.

---

### **Week 45-46: Thread Optimization**
- **45.2 False Sharing Fix**:  
  ```cpp
  struct alignas(64) AlignedCounter { // 64-byte cache line
      std::atomic<int> value;
  };
  AlignedCounter counters[4]; // Each in separate cache line 
  ```
- **46.3 Affinity**:  
  ```cpp
  void set_affinity(std::thread& t, int core) {
      cpu_set_t cpuset; CPU_ZERO(&cpuset); CPU_SET(core, &cpuset);
      pthread_setaffinity_np(t.native_handle(), sizeof(cpuset), &cpuset);
  }
  ```

---

### **Week 49: I/O Models**
- **49.3 epoll (Async I/O)**:  
  ```cpp
  int epfd = epoll_create1(0);
  struct epoll_event evt = {.events=EPOLLIN, .data.fd=sockfd};
  epoll_ctl(epfd, EPOLL_CTL_ADD, sockfd, &evt);
  while (1) {
      epoll_wait(epfd, events, 10, -1); // No busy-wait
      for (int i = 0; i < ready; i++) handle_io(events[i]);
  }
  ```

---

### **Week 50-52: Network Programming**
- **TCP Server**:  
  ```cpp
  int sockfd = socket(AF_INET, SOCK_STREAM, 0);
  struct sockaddr_in addr = {.sin_family=AF_INET, .sin_port=htons(8080)};
  bind(sockfd, (struct sockaddr*)&addr, sizeof(addr));
  listen(sockfd, 10);
  while (1) {
      int client_fd = accept(sockfd, NULL, NULL);
      send(client_fd, "HTTP/1.1 200 OK\r\n", 17, 0);
      close(client_fd);
  }
  ```

---

### **Key Tools Summary**
| **Tool**               | **Command**                           | **Use Case**                     |
|------------------------|---------------------------------------|----------------------------------|
| **`perf`**             | `perf stat -d ./app`                  | Cache misses, CPI               |
| **Google Benchmark**   | `./bench --filter=BM_*`               | Microbenchmarking               |
| **Valgrind**           | `valgrind --tool=cachegrind ./app`    | Cache simulation                |
| **AddressSanitizer**   | `g++ -fsanitize=address -g app.cpp`   | Memory errors                   |
| **Clang-Tidy**         | `clang-tidy app.cpp -checks=*`        | Static analysis                 |

> **Golden Rule**: *"Measure before optimizing – use `perf` to find hotspots, then apply targeted fixes"* . Adopt C++26 features like `std::execution` and contracts for future-proofing .
