Nanoprocessor Project

Overview:
This project contains the design and implementation of a nanoprocessor using VHDL in Xilinx Vivado. It includes two processor versions:
  1. Basic 3-bit Processor – A simple processor demonstrating fundamental concepts such as instruction decoding, arithmetic operations, and register management.
  2. Expanded 8-bit Processor – An enhanced version with wider data paths and more instructions, suitable for more complex operations and learning advanced digital design techniques.
The output is mapped to the 7 segment displays and LEDs to show the computed output, zero flag, negative flag and overflow flag.
Both designs serve as educational tools for understanding processor architecture and hardware design in VHDL

Features:
  *Instruction decoding and execution
  *Register file implementation
  *ALU with basic arithmetic and logic operations
  *Program ROM and memory handling
  *Support for both 3-bit and 8-bit data paths
  *FPGA constraints included for synthesis and implementation

Requirements:
  Xilinx Vivado (recommended version 2018 or later)
  Basic knowledge of VHDL and digital design concepts

Usage:
  Open Vivado and create a new project.
  Add the VHDL source files from either the 3-bit or 8-bit processor folder.
  Run Simulation to verify the design.
  Implement and generate the bitstream if targeting an FPGA.

Notes:
  The 3-bit processor is suitable for learning basic processor design.
  The 8-bit processor introduces more features and wider data handling.
  Testbenches are included for validating functionality.


