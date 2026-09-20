### eBPF Stateful TCP Connection Tracker

In-kernel TCP lifecycle monitoring built in **C** using **eBPF** and **XDP** for ultra-low overhead packet processing inside the Linux kernel data plane.

#### Key Features

- **In-Kernel State Tracking**: Monitored TCP handshakes and state transitions using BPF hash maps directly in kernel space.
- **Driver-Level XDP Hooks**: Processed incoming frames before network stack memory allocation to minimize latency.
- **Topology Benchmarking**: Simulated and tested traffic throughput within **Mininet** network topologies.
