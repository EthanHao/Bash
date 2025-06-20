### **Week 1: Processes & Threads Fundamentals**
#### 1.1 Main Function
**Concept**: Entry point of C/C++ programs. The OS loads the program into memory and starts execution here.  
**Code**:
```c
#include <stdio.h>
int main(int argc, char* argv[]) {
    printf("Arguments count: %d\n", argc);
    for (int i = 0; i < argc; i++) {
        printf("Arg %d: %s\n", i, argv[i]);
    }
    return 0;
}
```
**Tool**: Compile with `gcc -o program program.c`, run with `./program arg1 arg2`.

#### 1.2 Thread Call Function
**Concept**: Threads share process memory but have independent call stacks.  
**Code** (pthreads):
```c
#include <pthread.h>
#include <stdio.h>
void* thread_task(void* arg) {
    printf("Thread ID: %lu\n", (unsigned long)pthread_self());
    return NULL;
}
int main() {
    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_task, NULL);
    pthread_create(&t2, NULL, thread_task, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    return 0;
}
```
**Tool**: Compile with `gcc -pthread -o threads threads.c`.

#### 1.3 Address Space
**Concept**: Virtual memory layout:  
- **Text**: Code instructions  
- **Data**: Global/static variables  
- **Heap**: Dynamic memory (grows upward)  
- **Stack**: Function calls (grows downward)  

#### 1.4 Function Call Stack
**1.4.1 Direction**: Grows downward (high to low addresses) on x86/ARM.  
**1.4.2 Stack Overflow**:  
```c
void recursive_overflow() {
    char buffer[1024*1024];  // 1MB stack allocation
    recursive_overflow();
}
int main() { recursive_overflow(); }
```
**Tool**: Detect with `ulimit -s 1024` (limit stack to 1MB), then run program.

---

### **Week 2: Thread Optimization**
#### 2.1 Context Switch
**2.1.1 User→Kernel**: 100-500 cycles (syscall overhead).  
**2.1.2 User→User**: 10-100 cycles (fiber switching).  
**Tool**: Measure with `perf stat -e context-switches ./program`.

#### 2.2 Avoiding Context Switches
**Strategies**:  
- Use non-blocking I/O (`epoll`)  
- Thread pools with work-stealing queues  
```cpp
#include <thread>
#include <vector>
#include <queue>
#include <mutex>
std::queue<std::function<void()>> tasks;
std::mutex queue_mutex;
void worker() {
    while (true) {
        std::function<void()> task;
        {
            std::lock_guard<std::mutex> lock(queue_mutex);
            if (!tasks.empty()) {
                task = tasks.front();
                tasks.pop();
            }
        }
        if (task) task();
    }
}
```

#### 2.4 Benchmarking Tools
**Google Benchmark**:  
```cpp
#include <benchmark/benchmark.h>
static void BM_ThreadCreation(benchmark::State& state) {
    for (auto _ : state) {
        std::thread t([](){});
        t.join();
    }
}
BENCHMARK(BM_ThreadCreation);
BENCHMARK_MAIN();
```
**Run**: `g++ -O2 -lbenchmark -pthread bench.cpp -o bench && ./bench`.

---

### **Week 3: Integer Operations**
#### 3.1 Binary Representation
**Signed**: Two's complement  
**Unsigned**: Standard binary  
```c
int8_t signed_val = -5;     // 0xFB (251 in decimal)
uint8_t unsigned_val = 0xFB; // 251
```

#### 3.4 Bitwise Operations
```c
uint32_t a = 0xF0F0F0F0;
uint32_t b = a >> 4;       // 0x0F0F0F0F
uint32_t c = a & 0xCCCCCCCC; // Masking
```

#### 3.5 Arithmetic Optimizations
**Multiply by 15**: `x * 15` → `(x << 4) - x`  
**Divide by 2**: `x / 2` → `x >> 1`

---

### **Week 4: Integer Issues**
#### 4.2 Overflow/Underflow
```c
// Safe addition
bool safe_add(int32_t a, int32_t b, int32_t* res) {
    if (b > 0 && a > INT_MAX - b) return false;
    if (b < 0 && a < INT_MIN - b) return false;
    *res = a + b;
    return true;
}
```

#### 4.3 Endianness
```c
uint32_t num = 0x12345678;
uint8_t* p = (uint8_t*)&num;
bool is_little_endian = (p[0] == 0x78);  // true on x86
```

---

### **Week 5: Sorting Algorithms**
#### 5.2 Quicksort Optimization
```c
void quicksort(int arr[], int low, int high) {
    if (high - low < 16) insertion_sort(arr, low, high);
    else {
        int pivot = partition(arr, low, high);
        quicksort(arr, low, pivot-1);
        quicksort(arr, pivot+1, high);
    }
}
```
**Perf Tip**: Insertion sort for small arrays improves cache locality.

---

### **Week 8: Floating-Point Precision**
#### 8.3 Safe Comparison
```c
#include <math.h>
#include <float.h>
bool float_eq(float a, float b) {
    return fabs(a - b) <= FLT_EPSILON * fmax(fabs(a), fabs(b));
}
```

---

### **Week 9: SIMD Optimization**
```c
#include <immintrin.h>
void add_arrays(float* a, float* b, float* c, size_t n) {
    for (size_t i = 0; i < n; i += 8) {
        __m256 va = _mm256_load_ps(a + i);
        __m256 vb = _mm256_load_ps(b + i);
        __m256 vc = _mm256_add_ps(va, vb);
        _mm256_store_ps(c + i, vc);
    }
}
```
**Tool**: Compile with `gcc -mavx2 -O3 simd.c`.

---

### **Week 13: Memory Allocation**
#### 13.1 Small Allocation
**Behavior**: Glibc uses `brk()` for small objects (<128KB), `mmap()` for large.  
**Tool**: Trace with `ltrace ./program`.

#### 13.2 Large Allocation
```c
void* big_mem = malloc(1024 * 1024 * 512); // 512MB
// Uses mmap internally
```

---

### **Week 14: Memory Management**
#### 14.1 How free() Knows Size
**Secret**: Allocator stores metadata before returned pointer:  
```c
struct malloc_chunk {
    size_t size;
    // ... other metadata
};
```

#### 14.3 Memory Leak Detection
**Valgrind**:  
```bash
valgrind --leak-check=full ./program
```

---

### **Week 18: Cache Optimization**
#### 18.1 Row-Major vs Column-Major
```c
#define SIZE 1024
float matrix[SIZE][SIZE];

// Row-major: 2.5x faster
for (int i = 0; i < SIZE; i++) {
    for (int j = 0; j < SIZE; j++) {
        matrix[i][j] *= 2.0f;
    }
}
```
**Tool**: Profile with `perf stat -d ./program`.

---

### **Week 23: Vector Optimization**
```cpp
#include <vector>
int main() {
    std::vector<int> vec;
    vec.reserve(1000);  // Preallocate memory
    for (int i = 0; i < 1000; i++) vec.push_back(i);
    vec.shrink_to_fit();  // Reduce capacity
}
```

---

### **Week 32: BFS in Maze**
```cpp
struct Point { int x, y; };
bool bfs_maze(int grid[][100], int rows, int cols, Point start, Point end) {
    const int dx[4] = {0, 1, 0, -1};
    const int dy[4] = {1, 0, -1, 0};
    std::queue<Point> q;
    q.push(start);
    grid[start.x][start.y] = -1;  // Mark visited

    while (!q.empty()) {
        Point p = q.front(); q.pop();
        if (p.x == end.x && p.y == end.y) return true;
        for (int i = 0; i < 4; i++) {
            int nx = p.x + dx[i], ny = p.y + dy[i];
            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx][ny] == 0) {
                q.push({nx, ny});
                grid[nx][ny] = -1;
            }
        }
    }
    return false;
}
```

---

### **Week 45: False Sharing Solution**
```cpp
struct alignas(64) AlignedCounter {
    std::atomic<int> value;
};
AlignedCounter counters[4];  // Each in separate cache line
```

---

### **Week 46: Thread Affinity**
```c
#define _GNU_SOURCE
#include <sched.h>
void set_affinity(int core_id) {
    cpu_set_t cpuset;
    CPU_ZERO(&cpuset);
    CPU_SET(core_id, &cpuset);
    pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
}
```

---

### **Week 49: Async I/O with epoll**
```c
int epoll_fd = epoll_create1(0);
struct epoll_event event;
event.events = EPOLLIN | EPOLLET;  // Edge-triggered
event.data.fd = socket_fd;
epoll_ctl(epoll_fd, EPOLL_CTL_ADD, socket_fd, &event);

while (1) {
    struct epoll_event events[10];
    int n = epoll_wait(epoll_fd, events, 10, -1);
    for (int i = 0; i < n; i++) {
        if (events[i].events & EPOLLIN) {
            // Handle read without blocking
        }
    }
}
```

---

### **Week 50: TCP Server**
```c
int server_fd = socket(AF_INET, SOCK_STREAM, 0);
struct sockaddr_in addr = {
    .sin_family = AF_INET,
    .sin_port = htons(8080),
    .sin_addr.s_addr = INADDR_ANY
};
bind(server_fd, (struct sockaddr*)&addr, sizeof(addr));
listen(server_fd, 10);

while (1) {
    int client_fd = accept(server_fd, NULL, NULL);
    char buffer[1024];
    recv(client_fd, buffer, sizeof(buffer), 0);
    send(client_fd, "HTTP/1.1 200 OK\r\nContent-Length: 12\r\n\r\nHello world", 46, 0);
    close(client_fd);
}
```

---

### **Essential Tools Cheat Sheet**
| **Tool**         | **Command**                           | **Purpose**                     |
|------------------|---------------------------------------|---------------------------------|
| **perf**         | `perf stat -B ./program`              | Basic CPU counters              |
|                  | `perf record -g ./program`            | Call graph profiling            |
|                  | `perf report -n --stdio`              | Analyze profiling data          |
| **Valgrind**     | `valgrind --leak-check=yes ./program` | Memory leak detection           |
|                  | `valgrind --tool=cachegrind ./program`| Cache access analysis           |
| **GDB**          | `gdb -q ./program`                    | Debugging                       |
|                  | `watch -l *(int*)0x1234`              | Watch memory address            |
| **strace**       | `strace -c ./program`                 | System call tracing             |
| **AddressSanitizer**| `gcc -fsanitize=address -g prog.c`  | Runtime memory error detector   |
| **Google Benchmark** | `./bench --benchmark_filter=BM_*` | Microbenchmark execution      |

### **Key Performance Principles**
1. **Measure First**: Use `perf` to find bottlenecks before optimizing  
2. **Cache is King**: Optimize for spatial/temporal locality  
3. **Vectorize**: Use SIMD for data-parallel workloads  
4. **Concurrency**: Prefer thread pools over per-task threads  
5. **Zero-Cost Abstractions**: Leverage modern C++ without runtime overhead  

> **Golden Rule**: "Make it work, make it right, make it fast - in that order."  
> Profile → Identify bottleneck → Optimize → Measure impact → Repeat.
