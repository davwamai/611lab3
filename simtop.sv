/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

	logic clk;
	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	logic [3:0] KEY;
	logic [17:0] SW;

	top dut
	(
		//////////// CLOCK //////////
		.CLOCK_50(clk),
		.CLOCK2_50(),
	  .CLOCK3_50(),

		//////////// LED //////////
		.LEDG(),
		.LEDR(),

		//////////// KEY //////////
		.KEY(KEY),

		//////////// SW //////////
		.SW(SW),

		//////////// SEG7 //////////
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.HEX6(HEX6),
		.HEX7(HEX7)
	);

  // pulse reset (active low)
	initial begin
		KEY <= 4'he;
		#10;
		KEY <= 4'hf;
	end
	
	// drive clock
	always begin
		clk <= 1'b0; #5;
		clk <= 1'b1; #5;
	end
	
	// assign simulated switch values
	assign SW = 18'd123456;

  final begin
      // testcase bin2dec.asm
      $display("D5: %8d", dut.cpu_inst.rf_inst.mem[21]);
      $display("D4: %8d", dut.cpu_inst.rf_inst.mem[20]);
      $display("D3: %8d", dut.cpu_inst.rf_inst.mem[19]);
      $display("D2: %8d", dut.cpu_inst.rf_inst.mem[18]);
      $display("D1: %8d", dut.cpu_inst.rf_inst.mem[9]);
      $display("D0: %8d", dut.cpu_inst.rf_inst.mem[8]);
  end

endmodule

