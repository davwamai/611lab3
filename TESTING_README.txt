The testing strategy follows verifying the output values of the bin2dec program for a given input 123456. All instructions not used in the original bin2dec implementation are used to 'randomize' the 123456 input. This ensures all supported instructions are
ran at least once. The test suite compiles an extra version of the cpu.sv module that includes the secondary testing bin2dec hexcode called 'testing.rom' The test suite also implements a secondary simtop2 module similar to the original. Actual generated
values are compared against expected values inside the simtop2.sv module and results of the test are printed after the simulation has completed.

To run the test suite, invoke: bash runtest.sh
