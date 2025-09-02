# Assertion-Based-Verification-of-FIFO
This project designs and verifies an 8-bit wide, 16-depth synchronous FIFO in Verilog. A SystemVerilog testbench applies reset, writes, and reads beyond capacity to test overflow/underflow. Assertions ensure no write on full, no read on empty, and flags never conflict. Simulation in Vivado confirms correct behavior.
