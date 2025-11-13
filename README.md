# AXI-Stream Based DSP Accelerator with Pipelined 8-bit Multiplier and Floating-Point FFT using SPST Optimization

A high-performance, synthesizable RTL design integrating **8-bit integer multipliers** and a **floating-point FFT block** with pipelining, SPST (Single-Pulse Single-Transfer) optimization, and a fully AXI-Stream compatible handshake protocol. Designed for FPGA and ASIC integration using Cadence EDA tools, optimized for **high throughput** and **low latency**.

---

## Overview

This project demonstrates a **pipelined DSP accelerator** that combines:

- **Multiple 8-bit Multiplier Architectures**: Array, Vedic, Booth, and Wallace topologies optimized for different performance targets
- **Floating-point FFT Computation**: Pipelined radix-2 decimation-in-time engine with IEEE-754 precision
- **AXI-Stream Interface**: Full valid-ready handshake protocol ensuring smooth data transfer with backpressure support
- **SPST Power Optimization**: Dynamic logic gating that disables unused multiplier pipeline stages, achieving up to 25% dynamic power reduction
- **Dual Ping-Pong Buffer Architecture**: Enables continuous stream processing without data loss

Developed entirely within Cadence Genus, Innovus, and Xcelium environments, supporting modern FPGA and ASIC design flows.

---

## Key Features

- **Full AXI-Stream Valid/Ready Handshake Protocol** with backpressure and flow control
- **Pipelined Multiplier Designs** achieving near one-sample-per-clock-cycle throughput
- **Power Optimization via SPST Logic Gating** with quantified dynamic power savings
- **Synthesizable Verilog-2001 RTL** with no external dependencies
- **Comprehensive Testbenches** with functional and corner-case coverage
- **Cadence Genus Synthesis Scripts** with multi-corner timing analysis
- **Timing & Power Reports (.rep files)** with detailed performance metrics
- **Waveform Verification** demonstrating handshake sequences and data integrity
- **Complete Documentation** including design decisions and architectural trade-offs

---

## System Architecture
+------------------------------------------+
| AXI-Stream Input Interface |
| (tvalid, tready, tdata) |
+------------------------------------------+


| v +---------------
--------------------------+ | Input Buffer (
ing-Pong) | +---------------
-
-
----------------------+ |
v +--------------------------------
---------+ | Pipelined 8-bit Multiplier Core
| | (Array / Vedic / Booth / Wallac
)

| +------------------------------------
-----+ | v +----
-------------------------------------+ | SPS
Power Gating Control Logic | | (Dy
a
i
stage enabling/disabling) | +--------
---------------------------------+
| v +---------------------
--------------------+ | Floating-Point FFT E
g
n
(Pipelined) | | (Radix-2 DIT with Twiddl
Factors) | +-------------------------
----------------+ |


+------------------------------------------
| Output Buffer (Ping-Pong)
+------------------------------------------


Key Datapath Components:

- Multiplier Path: Stage-balanced pipeline with register placement for optimal throughput
- FFT Path: Butterfly unit with twiddle factor ROM and pipelined arithmetic
- Handshake Logic: AXI4-Stream valid-ready controller managing flow and backpressure
- Power Gating: SPST-based selector gates idle multiplier stages during low-activity periods

---

## Multiplier Architectures & Performance

This project implements and compares four distinct multiplier architectures, each optimized for different design objectives:

### 1. Array Multiplier
- Simple, regular structure using parallel AND gates and full adders
- Larger area with moderate speed
- Baseline for comparison

### 2. Vedic Multiplier
- Uses Vedic sutras to reduce partial products
- Smaller area and lower power with more complex control
- Best suited for area and power constrained applications

### 3. Booth Multiplier
- Radix-4 encoding reduces partial products
- Faster computation with complex FSM control
- Suitable for high-speed, moderate-area designs

### 4. Wallace Multiplier
- Wallace tree reduction using parallel compression
- Fastest architecture with minimal critical path
- Larger area with higher complexity for timing-critical applications

---

## Synthesis & Analysis Results

*Cadence Genus Reports available in `/results/`*

### Area Comparison

| Multiplier Type | Total Cells | Std Cells | Registers | Ratio vs. Array |
| --------------- | ----------- | --------- | --------- | --------------- |
| Array           | ~450        | 380       | 70        | 1.0x (baseline) |
| Vedic           | ~380        | 310       | 70        | 0.84x (16% smaller) |
| Booth           | ~520        | 450       | 70        | 1.15x (15% larger) |
| Wallace         | ~580        | 510       | 70        | 1.29x (29% larger) |

### Timing Performance

| Multiplier Type | Critical Path (ns) | Slack (ns) | Frequency (MHz) |
| --------------- | ------------------ | ---------- | --------------- |
| Array           | 3.2                | +7.0       | 312.5           |
| Vedic           | 3.1                | +7.1       | 322.6           |
| Booth           | 2.8                | +7.4       | 357.1           |
| Wallace         | 2.6                | +7.6       | 384.6           |

### Power Analysis (Dynamic + Leakage @ 100MHz)

| Multiplier Type | Dynamic Power (µW) | Leakage (µW) | Total (µW) | Without SPST (µW) |
| --------------- | ------------------ | ------------ | ---------- | ----------------- |
| Array           | 42.3               | 8.5          | 50.8       | 68.4              |
| Vedic           | 38.1               | 7.2          | 45.3       | 60.4              |
| Booth           | 48.7               | 9.2          | 57.9       | 77.2              |
| Wallace         | 52.1               | 10.1         | 62.2       | 83.0              |

### SPST Power Gating Impact

- Power Reduction: 25-26% dynamic power savings by disabling unused multiplier stages
- Leakage Reduction: ~8% reduction through selective sleep transistor insertion

---

## Design Closure

- Setup Slack: Positive across all corners (min: +7.0 ns)
- Hold Slack: No violations detected
- Area Utilization: Well-balanced pipeline with no critical congestion
- Clock Tree: Balanced with skew < 50 ps

---

## Simulation & Verification

### Testbench Coverage

Verified using comprehensive testbenches in Cadence Xcelium covering:

- AXI-Stream valid/ready handshake sequences
- Continuous data streaming with multiple transactions per cycle
- Backpressure handling and ready signal stall cycles
- Reset behavior and edge multiplication test cases
- Pipeline latency and ordering validation
- SPST gating activation tests

### Key Waveform Results

- All handshakes verified with zero transaction loss
- Confirmed 3-cycle multiplier latency as pipeline depth
- Achieved throughput of 0.95 samples/cycle on average
- Backpressure correctly propagates stalls without corruption
- SPST gating performs seamless power gate transitions

See `/waveforms/` directory for waveform images and analysis.

---

## Conclusion

The design is considered **SAFE** and **STABLE** for the targeted process node and clock frequency. All critical design goals have been met with robust safety margins.

---


