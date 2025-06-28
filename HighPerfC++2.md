### 1. Speed Differences in Memory Hierarchy  
**Access Time Comparison** (Modern Systems):  
| **Storage**       | **Access Time** | **Relative Speed** | **CPU Cycles** (3GHz CPU) |  
|-------------------|----------------|-------------------|--------------------------|  
| **CPU Registers** | 0.1-0.5 ns     | 1x (Baseline)     | 0.3-1.5 cycles           |  
| **L1 Cache**      | 0.5-1 ns       | 2-5x slower       | 1.5-3 cycles             |  
| **L2 Cache**      | 3-10 ns        | 10-30x slower     | 9-30 cycles              |  
| **L3 Cache**      | 15-50 ns       | 30-150x slower    | 45-150 cycles            |  
| **RAM**           | 50-100 ns      | 100-300x slower   | 150-300 cycles           |  
| **NVMe SSD**      | 10-100 μs      | 20,000-300,000x   | 30,000-300,000 cycles    |  
| **SATA SSD**      | 50-200 μs      | 100,000-600,000x  | 150,000-600,000 cycles   |  
| **7200 RPM HDD**  | 3-10 ms        | 6M-30Mx slower    | 9M-30M cycles            |  

**Key Implications**:  
- Register access is **~100,000x faster** than SSD access  
- 1 HDD seek = CPU could process **10 million instructions**  
- Cache misses can stall CPU pipelines (performance killer)  

---

### 2. What are Registers?  
Registers are the CPU's **ultra-fast onboard memory cells**:  
- **Physical Location**: Inside CPU cores (closest to ALU)  
- **Capacity**:  
  - x86-64: 16 general-purpose registers (RAX, RBX, RCX, RDX, etc.)  
  - Each 64-bit wide (8 bytes)  
- **Operations**:  
  ```asm
  mov eax, 5      ; Load 5 into register EAX
  add ebx, eax     ; Add EAX to EBX (result in EBX)
  ```
- **Compiler Usage**:  
  ```cpp
  int a = 10;      // Likely stored in register
  int b = a * 2;   // Arithmetic happens in register
  ```
- **Key Restrictions**:  
  - No addresses (can't point to registers)  
  - Limited quantity (spilling to RAM causes slowdowns)  

---

### 3. C++ Variables  
#### 3.1 Data Types & Sizes (x64 System)  
| **Type**      | **Size** | **Range/Values**               | **Example**             |  
|---------------|----------|--------------------------------|-------------------------|  
| `bool`        | 1 byte   | `true`/`false`                 | `bool flag = true;`     |  
| `char`        | 1 byte   | -128 to 127                    | `char c = 'A';`         |  
| `int`         | 4 bytes  | -2³¹ to 2³¹-1 (-2B to 2B)      | `int count = 100;`      |  
| `float`       | 4 bytes  | ±3.4e±38 (~7 sig digits)       | `float pi = 3.14159f;`  |  
| `double`      | 8 bytes  | ±1.7e±308 (~15 sig digits)     | `double d = 2.71828;`   |  
| `int[5]`      | 20 bytes | Contiguous memory              | `int arr[5] = {0};`     |  
| `int*`        | 8 bytes  | Memory address                 | `int* ptr = &count;`    |  

#### 3.4 Declaration vs. Definition  
- **Declaration**: Introduces name and type (*no memory allocation*)  
  ```cpp
  extern int globalVar;  // Declaration (in header)
  void foo(int x);       // Function declaration
  ```
- **Definition**: Allocates storage and provides implementation  
  ```cpp
  int globalVar = 42;    // Definition (in .cpp)
  void foo(int x) {      // Function definition
      cout << x;
  }
  ```

#### 3.5 Variable Scope  
```cpp
int global = 10;         // Global scope (entire program)

int main() {
    int local = 20;      // Local scope (main() block only)
    
    { 
        int inner = 30;  // Block scope (inside {})
    }
    
    static int counter = 0;  // Static (persists between calls)
    auto name = "John";  // auto = const char* (type deduction)
}
```

| **Scope Type** | **Lifetime**         | **Access**               |  
|----------------|----------------------|--------------------------|  
| Global         | Entire program       | Any file (with `extern`) |  
| Local          | Block execution      | Within `{ }`             |  
| Static         | Program execution    | Depends on location      |  
| Auto           | Same as declaration  | Type deduced at compile  |  

---

### 4. Functions & Call Mechanics  
#### 4.1 Calling Conventions (x86 Windows)  
| **Convention** | **Parameter Passing**     | **Stack Cleanup** | **`this` Pointer** |  
|----------------|---------------------------|-------------------|--------------------|  
| `__cdecl`      | Right-to-left on stack    | Caller            | ❌                 |  
| `__fastcall`   | ECX/EDX + stack           | Callee            | ❌                 |  
| `__thiscall`   | ECX (`this`) + stack      | Callee            | ✅ (C++ classes)   |  

#### 4.2 Call Stack  
**Stack Structure During `func(10, 20)`**:  
```
Higher Addresses
┌──────────────┐
│ Caller's     │
│ Local Vars   │
├──────────────┤
│ Return Addr  │ ← ESP after call
├──────────────┤
│ Parameter 1  │ (20)
├──────────────┤
│ Parameter 2  │ (10)
├──────────────┤
│ Saved EBP    │ ← Current EBP
├──────────────┤
│ Local Vars   │ ← Callee's space
└──────────────┘
Lower Addresses
```

#### 4.3 Caller/Callee  
```cpp
// CALLER
int main() {
    int result = add(10, 20);  // Caller
}

// CALLEE
int add(int a, int b) {         // Callee
    return a + b;
}
```

#### 4.4 Argument → Parameter  
- **Argument**: Actual value passed (`10`, `20`)  
- **Parameter**: Function's variable (`int a`, `int b`)  
- **Mechanism**:  
  ```asm
  push 20       ; Argument 2
  push 10       ; Argument 1
  call add      ; Return address pushed
  ```

#### 4.5 Function Declaration vs. Definition  
```cpp
// DECLARATION (header)
double calcInterest(double principal, int years);

// DEFINITION (.cpp)
double calcInterest(double principal, int years) {
    return principal * pow(1.05, years);
}
```

---

### 5. C++ → Machine Code Pipeline  
#### 5.1 Preprocessing (`g++ -E main.cpp -o main.ii`)  
- Processes `#include`, `#define`, macros  
- Output: Pure C++ without directives  

#### 5.2 Compilation to Assembly (`g++ -S main.ii -o main.s`)  
```asm
main.s:
    .globl  _main
_main:
    pushq   %rbp
    movq    %rsp, %rbp
    movl    $5, -4(%rbp)
    ...
```

#### 5.3 Assembly → Object File (`g++ -c main.s -o main.o`)  
- `objdump -d main.o` shows machine code:  
  ```
  0000000000000000 <_main>:
    55        push   %rbp
    48 89 e5  mov    %rsp,%rbp
    c7 45 fc  movl   $0x5,-0x4(%rbp)
  ```

#### 5.4 Linking (`g++ main.o utils.o -o app.exe`)  
- Resolves external references  
- Combines object files + libraries  
- Creates executable with PE/ELF format  

---

### Key Takeaways  
1. **Memory Hierarchy**: Registers are 100,000x faster than SSDs  
2. **Registers**: CPU's fastest storage (compiler-managed)  
3. **Variables**:  
   - Declaration ≠ Definition  
   - Scope controls lifetime/visibility  
4. **Functions**:  
   - Calling conventions govern parameter passing  
   - Stack grows downward (PUSH/POP operations)  
5. **Compilation Pipeline**:  
   Preprocess → Compile → Assemble → Link
