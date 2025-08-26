# High-Performance 8-bit Multipliers with Pipelining and SPST Optimization

## 📌 Overview
This repository contains multiple **8-bit multiplier architectures** implemented in **Verilog HDL**, optimized for **low power and high speed** using:

- ✅ **Wallace Tree Multiplier** (Fast parallel reduction)
- ✅ **Array Multiplier** (Simple structured design)
- ✅ **Booth Multiplier** (Signed multiplication support)
- ✅ **Vedic Multiplier** (Based on Urdhva Tiryakbhyam algorithm)

Each design supports:
- **3-Stage Pipelining** for high operating frequency
- **SPST (Spurious Power Suppression Technique)** for low-power optimization by skipping unnecessary computations

---

## 🚀 Features
- **Multiple Architectures**: Compare Wallace, Array, Booth, and Vedic multipliers.
- **IEEE-754 Floating Point FFT Block** (Optional advanced use case).
- **Pipelined Design**: Three stages for better timing performance.
- **SPST Gating**: Saves power when inputs contain zeros.
- **Synthesizable in Cadence / Synopsys / Vivado / Quartus**.
- **Simulation Ready** with testbenches for all designs.

---


---

## 🏗️ Design Details
### **1. Wallace Tree Multiplier**
- Parallel carry-save reduction for faster multiplication.
- Pipelined for 3 stages.
- SPST applied at partial product generation.

### **2. Array Multiplier**
- Classical shift-add structure.
- Simple, easy to understand.
- Pipelined with SPST gating for zero rows.

### **3. Booth Multiplier**
- Handles **signed numbers** efficiently.
- Uses **Booth's algorithm** to reduce partial products.
- 3-stage pipelined for higher speed.

### **4. Vedic Multiplier**
- Based on **Urdhva Tiryakbhyam Sutra**.
- Produces results in parallel.
- Includes SPST and pipelining for low power.

---

## ⚡ Pipelining & SPST
- **Stage 1**: Input Latching
- **Stage 2**: Partial Product Calculation
- **Stage 3**: Final Addition & Output
- **SPST**: Skips multiplication if one operand = 0, reducing dynamic power.

---

## ✅ How to Run
### **Simulation**
- Open **ModelSim / Cadence Xcelium / Vivado Simulator**.
- Compile all Verilog files in respective files .
- Run the corresponding testbench from `tb/`.

