// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f, ir);

  input clk, rst_f;
  input [31:0] ir;
 
// declare all internal wires here

wire [31:0] Ra, Rb, alu_result, in, outW, rsa, rsb,read_data, ir;
wire [1:0] alu_op;
wire  stat_en, wb_sel, rf_we;
 
// component instantiation goes here

	mux4 u1 (.in_a(ir[23:20]), .in_b(ir[15:12]), .sel(rd_sel), .out(outB)); 
	rf u2 (.clk(clk), .read_rega(ir[19:16]), .read_regb(outB), .write_reg(ir[23:20]), .write_data(outW), .rf_we(rf_we), .rsa(rsa), .rsb(rsb)); 
	ctrl u3 (.clk(clk), .rst_f(rst_f), .opcode(ir[31:28]), .mm(ir[27:24]), .stat(outS), .rf_we(rf_we), .alu_op(alu_op), .wb_sel(wb_sel));
	statreg u4 (.clk(clk), .in(cc), .enable(stat_en), .out(outS)); 
	mux32 u5 (.in_a(read_data), .in_b(alu_result), .sel(wb_sel), .out(outW)); 
	alu u6 (.clk(clk), .rsa(rsa), .rsb(rsb), .imm(ir[15:0]), .alu_op(alu_op), .alu_result(alu_result), .stat(cc), .stat_en(stat_en)); 

// put a $monitor statement here.  
initial

	
	 $monitor ($time,,," IR: %h, R1=%h, R2=%h, R3=%h, R4=%h, R5=%h, ALU_OP=%b, ALU_RESULT=%b", ir, u2.ram_array[1], u2.ram_array[2], u2.ram_array[3], u2.ram_array[4], u2.ram_array[5], alu_op, alu_result);
	




endmodule

