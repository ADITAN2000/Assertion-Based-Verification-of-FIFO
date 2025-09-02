# Assertion-Based-Verification-of-FIFO
This project designs and verifies an 8-bit wide, 16-depth synchronous FIFO in Verilog. A SystemVerilog testbench applies reset, writes, and reads beyond capacity to test overflow/underflow. Assertions ensure no write on full, no read on empty, and flags never conflict. Simulation in Vivado confirms correct behavior.

🔹Objective
The goal of this project was to design a synchronous FIFO (First-In First-Out) memory buffer and verify its functionality using Assertion-Based Verification (ABV) methodology in SystemVerilog. Assertions were used to capture design intent and automatically check corner-case scenarios like overflow, underflow, and protocol violations.

🔹 FIFO Design (RTL)
Implemented a synchronous FIFO with parameters:
Data width: 8 bits
Depth: 16 locations
RTL included:
Write pointer & Read pointer management
Full and Empty flag generation
Synchronous read/write operations
Coded in Verilog and simulated in Xilinx Vivado.

🔹 Verification Methodology
Built a SystemVerilog testbench with clock/reset generation, stimulus, and coverage points.
Applied Assertion-Based Verification (ABV) to validate FIFO properties.
Key Assertions Used:
No write when FIFO is full → prevents overflow.
No read when FIFO is empty → prevents underflow.
Full and Empty flags cannot be high simultaneously → ensures pointer logic correctness.
Data integrity → data read must match data written (checked via scoreboard).

🔹 Outcomes
Assertions successfully caught illegal conditions during corner-case simulation.
Improved verification efficiency by automatically detecting protocol violations without manual waveform debugging.
Demonstrated strong understanding of FIFO design, Verilog RTL coding, SystemVerilog assertions, and modern verification practices.

🔹 Skills Highlighted
RTL Design (FIFO, pointers, flag logic)
SystemVerilog Assertions (ABV)
Testbench Development
Debugging & Simulation in Vivado
