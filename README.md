# AXI-Stream Based DSP Accelerator with Pipelined 8-bit Multiplier and Floating-Point FFT using SPST Optimization

A high-performance, synthesizable RTL design integrating **8-bit integer multipliers** and a **floating-point FFT block** with pipelining, SPST (Single-Pulse Single-Transfer) optimization, and a fully AXI-Stream compatible handshake protocol. Designed for FPGA and ASIC integration, optimized for **high throughput** and **low latency**.

---

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [System Architecture](#system-architecture)
- [AXI Handshake Protocol](#axi-handshake-protocol)
- [File Structure](#file-structure)
- [Usage Instructions](#usage-instructions)
- [Timing and Power Analysis](#timing-and-power-analysis)
- [Design Safety](#design-safety)
- [Future Work](#future-work)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

This project demonstrates a **pipelined DSP accelerator** that combines:

- High-speed 8-bit integer multipliers
- Floating-point FFT computation with pipelining
- AXI-Stream handshake interface ensuring smooth data transfer
- SPST optimization for power savings by disabling unused logic dynamically

Easy to integrate into SoCs or DSP pipelines targeting modern FPGA and ASIC flows.

---

## Key Features

- Full **AXI-Stream Valid/Ready handshake** protocol support
- Pipeline design achieving near one sample per clock cycle throughput
- Power optimization via **SPST (Single-Pulse Single-Transfer)** logic gating
- Synthesizable Verilog RTL
- Verified testbench with waveform analysis
- Compatible with Cadence Genus synthesis and implementation tools

---

## System Architecture

+---------------------------------+
| AXI-Stream In --> |
| Multiplier & FFT Core |
| (Pipelined + SPST Control) --> AXI-Stream Out
+---------------------------------+
^ ^
| |
Handshake Logic Handshake Logic


The accelerator includes:

- **Multiplier path:** 8-bit pipelined integer multiplier
- **FFT path:** Floating-point FFT engine with stages pipelined for throughput
- **Handshake:** Implements AXI-Stream valid-ready logic for flow control and backpressure

---

## AXI Handshake Protocol

- Input signals: `tvalid`, `tready`, `tdata`
- Output signals: `tvalid`, `tready`, `tdata`

Data transfer occurs only when both `tvalid` and `tready` are high, supporting flow control and backpressure.

---

## File Structure

- `rtl/` — Verilog RTL sources
- `tb/` — Testbench and waveform files for verification
- `scripts/` — Cadence Genus synthesis & analysis TCL scripts
- `constraints/` — SDC timing constraints files
- `docs/` — Documentation and diagrams

---

## Usage Instructions

2. Synthesize the design using Cadence Genus:

    ```
    source scripts/rcscript2.tcl  # For max timing slow library
    source scripts/rcscript3.tcl  # For min timing fast library
    ```

3. Simulate using the testbench files in `tb/`.

---

## Timing and Power Analysis

Synthesis scripts generate timing and power reports (`.rep` files) showing performance metrics like critical path delay and power consumption.

---

## Design Safety

- The latest timing report indicates all timing paths meet constraints with **large positive slack margins (~7 ns)**, showing no setup or hold violations.
- The design achieves stable operation at intended clock speeds.
- Power estimates reflect SPST-based optimizations leading to reduced dynamic power.
- Gate-level area reports confirm a balanced pipeline with ample sequential and combinational resource allocation.

This confirms the design can be considered **safe and stable** for the targeted process and frequency.

---

## Future Work

- Support larger configurable FFT sizes (256, 512, 1024, etc.)
- Integrate AXI4-Lite control interface for configurability
- Implement clock gating for improved power efficiency
- FPGA implementation and resource utilization benchmarking

---

## Contributing

Contributions are welcome! Feel free to fork the repo, add features or tests, and submit pull requests.

---

## License

This project is licensed under the MIT License.

---

Thank you for your interest and support.

---

Any questions or suggestions? Please open an issue or contact the maintainers.

