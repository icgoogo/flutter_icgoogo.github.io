# CTF

[![Cybersecurity](https://img.shields.io/badge/Focus-Offensive%20%26%20Defensive%20Security-6f42c1)](#)
[![Binary Exploitation](https://img.shields.io/badge/Domain-Binary%20Exploitation-c0392b)](#binary-exploitation--memory-safety)
[![Reverse Engineering](https://img.shields.io/badge/Domain-Reverse%20Engineering-16a085)](#reverse-engineering--symbolic-execution)
[![Web Security](https://img.shields.io/badge/Domain-Web%20Security-2980b9)](#web-application-security)

## Technical Focus & Acquired Skills

Several challenges solved is available here: [Github Repo](https://github.com/icgoogo/ctf_writeups)

### Binary Exploitation

- **Return-Oriented Programming (ROP):** Gadget identification, stack pivot techniques, register control, ret2libc-style chains, and constructing payloads under strict character or space constraints.
- **Heap Exploitation:** Allocator state manipulation (glibc malloc), fastbin duplication, chunk corruption, arbitrary read/write primitives, libc address leaks, and targeting function hooks (`__malloc_hook`).
- **Mitigation Bypasses:** Circumventing stack canaries, PIE rebasing, ASLR, NX/DEP, and pointer protection mechanisms via runtime information disclosures.
- **Kernel Exploitation:** Device driver interaction via `ioctl`, kernel control-flow redirection, credentials/privilege escalation primitives, and handling kernel-level race conditions.
- **Shellcoding:** Writing direct x86/x86-64 syscalls, constrained/alphanumeric payloads, multistage execution, and memory layout mapping (`open-read-write`, `open-mmap-write`).

### Reverse Engineering & Symbolic Execution

- **Binary Disassembly & Decompilation:** Reconstructing program logic, extracting algorithms/cryptographic constants, and analyzing packed binaries.
- **Symbolic Execution & SMT Solving:** Automating path exploration, constraint solving, and flag/key recovery using `angr` and `Z3`.
- **Dynamic Analysis & Debugging:** Native runtime inspection, memory tracing, anti-debugging analysis, and validating static analysis hypotheses against live process behavior.

### Web & Network Security

- **Web Application Testing:** Request/response manipulation, session state and cookie security analysis, authentication/authorization flaw identification, and CSP analysis.
- **Vulnerability Analysis:** Practical exploitation of SQL Injection, Cross-Site Scripting (XSS), client-side DOM vulnerabilities, and server-side request processing edge cases.
- **Network Reconnaissance:** Port and service enumeration with Nmap, attack-surface mapping, public vulnerability assessment, and controlled exploit validation against lab environments.

---

## Tools

- **Binary Exploitation:** Pwntools, GDB (GEF/Pwndbg), C, x86/x86-64 Assembly, Linux Kernel/Syscalls
- **Reverse Engineering:** Ghidra, IDA Free, `libdebug`, `objdump`, `strings`, `file`
- **Symbolic Execution:** `angr`, Z3 SMT Solver
- **Web Security:** Burp Suite, Browser DevTools, `curl`, Python
- **Network & Assessment:** Nmap, Metasploit/Public Exploit Validation, Netcat
- **Scripting & Automation:** Python 3, Bash, C |

---

#### Mostly Part of Applied coursework in Offensive & Defensive Cybersecurity and Computer Security at Politecnico di Milano
