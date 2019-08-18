# Hardware Arithmetic
This repository is a collection of basic arithmetic-related hardware modules
defined in VHDL. Originally, these components were implemented in the [Xilinx
ISE Design Suite](https://www.xilinx.com/products/design-tools/ise-design-suite.html)
and mapped onto Xilinx Spartan FPGAs for demonstration purposes but it is
possible to compile and simulate them with the open-source
[GHDL](https://github.com/ghdl/ghdl) compiler and simulator.

The simulated behaviour can be easily displayed with the likewise open-source
[GTKWave](http://gtkwave.sourceforge.net/) viewer.

## Included modules
1. Simple ALU with basic operations (add, and, or, left shift)
2. Redundant Binary Adder
3. Bitonic Sorter Network

(The detailed description of each module is placed into its own directory.)

## TODO
* [ ] Add GHDL-based build and test scripts to the modules.

## License
This library is distributed under the terms and conditions of the MPL v2.0. 
Copyright &copy; 2019, 0l-l0
