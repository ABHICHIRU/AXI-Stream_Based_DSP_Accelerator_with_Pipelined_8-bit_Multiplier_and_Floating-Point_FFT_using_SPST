# AXI-Stream DSP Accelerator: 8-bit Multiplier + Floating-Point FFT (Handshake Interface)

A high-performance, synthesizable RTL design that integrates **8-bit integer multipliers** and a **floating-point FFT block** with pipelining, SPST (Single-Pulse Single-Transfer) optimization, and a fully AXI-Stream compatible handshake protocol.  
This project is designed for FPGA/ASIC integration and optimized for **high throughput** and **low latency**.

---

## 📑 Table of Contents
- [Overview](#overview)
- [Key Features](#key-features)
- [System Architecture](#system-architecture)
- [AXI Handshake Protocol](#axi-handshake-protocol)
- [File Structure](#file-structure)
- [Usage Instructions](#usage-instructions)
- [Reports & Results](#reports--results)
- [Performance Benchmarks](#performance-benchmarks)
- [Future Work](#future-work)
- [Contributing](#contributing)
- [License](#license)

---

## 🔎 Overview

This project demonstrates a **pipelined DSP accelerator** with:
- **8-bit integer multipliers** (high-speed)
- **Floating-point FFT computation**
- **AXI-stream handshake interface** for data transfer
- **SPST optimization** to minimize power by disabling unused logic dynamically

It can be easily integrated into a larger SoC or DSP pipeline.

---

## 🚀 Key Features

- ✅ **AXI-Stream Valid/Ready handshake** interface  
- ✅ **High-throughput pipelining** to achieve near one-sample-per-cycle throughput  
- ✅ **SPST Optimization** for power savings  
- ✅ Synthesizable RTL (Verilog)  
- ✅ **Fully verified testbench with waveform analysis**  
- ✅ Compatible with Cadence Genus 

---

## 🏗 System Architecture
        +---------------------------+
AXI-Stream | | AXI-Stream
In ---> | Multiplier / FFT Core | ---> Out
| (Pipelined + SPST Control) |
+---------------------------+
^ ^
| |
Handshake Handshake
Logic Logic
- **Multiplier Path:** 8-bit high-speed integer multiplier  
- **FFT Path:** Floating-point FFT engine with pipelined stages  
- **Handshake Logic:** Implements AXI-Stream valid/ready protocol  

---

## 🔄 AXI Handshake Protocol

Implements **valid/ready handshake**:

- **Input:** `tvalid`, `tready`, `tdata`  
- **Output:** `tvalid`, `tready`, `tdata`  

Operation:

1. Input source asserts `tvalid` when data is ready.  
2. Design asserts `tready` when ready to accept new data.  
3. Data is transferred only when **both are HIGH**.  
4. Backpressure supported — if `tready` is LOW, upstream must hold data.  

---

🧭 Future Work

Support for configurable FFT sizes (e.g. 256, 512, 1024 points)

Clock gating for better power reduction

Integration with AXI4-Lite control interface

FPGA implementation results with resource utilization

🤝 Contributing

Contributions are welcome!
Fork this repository, add improvements (testbenches, RTL optimizations, documentation), and submit a PR.


