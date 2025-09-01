# **High-Performance 8-bit Multipliers & Floating-Point FFT with Pipelining and SPST Optimization**

---

## 📌 **Overview**
This repository contains **multiple 8-bit multiplier architectures** and an **optional advanced 8-point FFT block**, all implemented in **Verilog HDL**, optimized for **low power and high speed** using:

✅ **Wallace Tree Multiplier** (Fast parallel reduction)  
✅ **Array Multiplier** (Simple structured design)  
✅ **Booth Multiplier** (Signed multiplication support)  
✅ **Vedic Multiplier** (Based on Urdhva Tiryakbhyam algorithm)  
✅ **8-Point FFT Block** with **IEEE-754 Floating-Point Operations**  

Each design supports:

✔ **3-Stage Pipelining** for high operating frequency  
✔ **SPST (Spurious Power Suppression Technique)** for low-power optimization by skipping unnecessary computations  

---

## 🚀 **Features**
- **Multiple Architectures:** Compare Wallace, Array, Booth, and Vedic multipliers.
- **IEEE-754 Floating-Point FFT Block:** Unrolled, pipelined design for DSP.
- **Complex Number Support:** Handles both real and imaginary inputs for FFT.
- **Custom Floating-Point Unit:** Includes addition, subtraction, and multiplication logic in Verilog.
- **Pipelined Design:** Three stages for better timing performance.
- **SPST Gating:** Saves power when inputs contain zeros.
- **Synthesizable:** Works in **Cadence / Synopsys / Vivado / Quartus**.
- **Simulation Ready:** Includes **testbenches** for all designs.

---

## 🏗️ **Design Details**

### **1. Wallace Tree Multiplier**
- Parallel **carry-save reduction** for faster multiplication.
- Fully **pipelined** for 3 stages.
- **SPST** applied at partial product generation.

### **2. Array Multiplier**
- Classical **shift-add** structure.
- Simple, easy to understand.
- **Pipelined** with SPST gating for zero rows.

### **3. Booth Multiplier**
- Handles **signed numbers efficiently**.
- Uses **Booth's algorithm** to reduce partial products.
- **3-stage pipelined** for higher speed.

### **4. Vedic Multiplier**
- Based on **Urdhva Tiryakbhyam Sutra**.
- Produces results in **parallel**.
- Includes **SPST and pipelining** for low power.

### **5. 8-Point FFT Block (Advanced)**
- **Fully Unrolled FFT**: All stages expanded, no loops.
- **IEEE-754 Floating-Point Support**:
  - Addition, subtraction, multiplication implemented in Verilog.
- **Complex Number Processing**:
  - `real_in` / `imag_in` inputs → `real_out` / `imag_out` outputs.
- **Frame Buffer** for 8 inputs with pipeline scheduling.
- **Pipelined Output Streaming**:
  - Processes 8-point FFT in **3 pipeline stages**.
- **Optimized for DSP**:
  - Twiddle constants like `±0.7071` hard-coded for fast multiplication.
- **SPST-ready** for zero or unity twiddle factors.

---

## 🖼 **Block Diagram & Architecture**
- **FFT Block Diagram:**  
![FFT Block Diagram](./docs/fft_block_diagram.png)  

- **FFT Architecture Diagram:**  
![FFT Architecture Diagram](./docs/fft_architecture.png)  

*(Place the generated diagrams in a folder named `docs/` before pushing to GitHub.)*

---

## ⚡ **Pipelining & SPST**
- **Stage 1:** Input Latching  
- **Stage 2:** Partial Product or Butterfly Calculation  
- **Stage 3:** Final Addition & Output  
- **SPST:** Skips multiplication if one operand = 0 → **reduces dynamic power**.

---

## ✅ **How to Run**

### **Simulation**
1. Open **ModelSim / Cadence Xcelium / Vivado Simulator**.
2. Compile all Verilog files.
3. Run the corresponding testbench from `tb/`.

---

## 🔍 **Testbenches Included**
- Each multiplier has:
  - **Basic cases:** small values, zeros.
  - **Corner cases:** max values, signed inputs.
- FFT block:
  - 8 complex input samples.
  - Includes **unique cases** (positive, negative, zeros, large values).
  - Validates **floating-point operations**.

---

## 📈 **Future Improvements**
- Add **16/32-point FFT** support.
- Replace custom FP logic with **IEEE-compliant FP unit**.
- Add **Fused Multiply-Add (FMA)** for higher performance.
- Implement **dual-port RAM buffering** for streaming FFT.

---

✅ **This design is ideal for:**
- **Low-power DSP systems** (FPGAs, ASICs).
- **High-performance multipliers for AI/ML kernels**.
- **Educational projects** demonstrating multiple architectures.

---

---

## 🔗 **License**
MIT License – Free to use for academic and personal projects.

---

### ✅ Want GitHub to render diagrams **without image files**?
Use **Mermaid diagrams** instead of PNGs:

```mermaid
graph TD
    A[Input Stage] --> B[Pipeline Stage 1: Partial Products]
    B --> C[Pipeline Stage 2: Reduction/Butterfly]
    C --> D[Pipeline Stage 3: Output]

