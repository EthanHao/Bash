### POSIX API: Basic Introduction

**POSIX (Portable Operating System Interface)** is a family of standards specified by IEEE for maintaining compatibility between operating systems. The POSIX API provides a standardized interface for process control, threading, file operations, and system interaction on Unix-like systems (Linux, macOS, BSD).

---

### 🔑 Core POSIX Components

#### 1. **Process Management**
   - **`fork()`**: Creates child process (exact copy of parent)
     ```c
     pid_t pid = fork();
     if (pid == 0) { /* Child process */ }
     else if (pid > 0) { /* Parent process */ }
     ```
   - **`exec()` Family**: Replaces current process with new program
     ```c
     execl("/bin/ls", "ls", "-l", NULL);
     ```
   - **`wait()`/`waitpid()`**: Parent waits for child to exit
     ```c
     int status;
     waitpid(child_pid, &status, 0);
     ```

#### 2. **POSIX Threads (pthreads)**
   - **`pthread_create()`**: Spawns new thread
     ```c
     pthread_t thread;
     pthread_create(&thread, NULL, thread_func, NULL);
     ```
   - **`pthread_join()`**: Waits for thread termination
     ```c
     pthread_join(thread, NULL);
     ```
   - **`pthread_exit()`**: Terminates calling thread
     ```c
     pthread_exit(NULL);
     ```

#### 3. **Synchronization**
   - **Mutexes** (Mutual Exclusion):
     ```c
     pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
     pthread_mutex_lock(&mutex);
     /* Critical section */
     pthread_mutex_unlock(&mutex);
     ```
   - **Condition Variables**:
     ```c
     pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
     pthread_cond_wait(&cond, &mutex);  // Wait for signal
     pthread_cond_signal(&cond);         // Wake one waiter
     ```

#### 4. **IPC (Inter-Process Communication)**
   - **Pipes**:
     ```c
     int pipefd[2];
     pipe(pipefd);  // Creates unidirectional pipe
     ```
   - **Shared Memory**:
     ```c
     int shm_fd = shm_open("/my_shm", O_CREAT | O_RDWR, 0666);
     ftruncate(shm_fd, SIZE);
     void *ptr = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
     ```

#### 5. **File System**
   - **Low-level I/O**:
     ```c
     int fd = open("file.txt", O_RDONLY);
     read(fd, buffer, sizeof(buffer));
     close(fd);
     ```

---

### 📝 Key Headers
```c
#include <unistd.h>      // Process control (fork, exec, pipe)
#include <pthread.h>     // Thread operations
#include <sys/wait.h>    // Wait functions
#include <sys/mman.h>    // Shared memory
#include <fcntl.h>       // File control options
```

---

### ⚖️ Process vs. Thread POSIX Comparison
| **Feature**          | **Process**                  | **Thread (pthread)**         |
|----------------------|------------------------------|------------------------------|
| **Creation**         | `fork()`                     | `pthread_create()`           |
| **Termination**      | `exit()`                     | `pthread_exit()`             |
| **Waiting**          | `waitpid()`                  | `pthread_join()`             |
| **Identifier**       | `pid_t` (Process ID)         | `pthread_t` (Thread ID)      |
| **Memory Space**     | Separate                     | Shared within process        |
| **Context Switch**   | Heavyweight (OS involvement) | Lightweight (user-space)     |
| **Communication**    | IPC (pipes, shared memory)   | Shared variables (with sync) |

---

### 💡 Why Use POSIX API?
1. **Portability**: Code works across Unix-like systems
2. **Granular Control**: Low-level system access
3. **Efficiency**: Lightweight threading model
4. **Standardization**: Consistent interface across platforms
5. **Real-time Support**: Priority scheduling, timers

---

### 🚀 Minimal Thread Example
```c
#include <pthread.h>
#include <stdio.h>

void* hello(void* arg) {
    printf("Hello from thread!\n");
    return NULL;
}

int main() {
    pthread_t tid;
    pthread_create(&tid, NULL, hello, NULL);
    pthread_join(tid, NULL);
    return 0;
}
```
Compile with: `gcc program.c -pthread -o program`

---

### ⚠️ Key Considerations
- **Error Handling**: Always check return values
  ```c
  if (pthread_create(&tid, NULL, func, NULL) != 0) {
      perror("Thread creation failed");
  }
  ```
- **Resource Cleanup**: Destroy mutexes/semaphores
- **Thread Safety**: Use mutexes for shared resources
- **Cancellation Points**: Design threads to handle cancellation

The POSIX API provides the fundamental building blocks for system programming on Linux/Unix systems, enabling direct interaction with the operating system's process management, threading, and IPC facilities.
