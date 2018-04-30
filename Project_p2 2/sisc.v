// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f);

  input clk, rst_f;
  //input [31:0] ir;

// declare all internal wires here

wire [31:0] Ra, Rb, alu_result, in, outW, rsa, rsb,read_data, ir, temp;
wire [1:0] alu_op;
wire [15:0] br_addr, pc_out, pc_inc, outMx;
wire  stat_en, wb_sel, rf_we, rd_sel, br_sel, pc_rst, pc_write, pc_sel, ir_load, dm_we, mm_sel;
wire [3:0] outS, cc, outB;
 
// component instantiation goes here
//assign sel = 1'b0;      
//assign temp = 0;

	mux4 u1 (.in_a(ir[23:20]), .in_b(ir[15:12]), .sel(rd_sel), .out(outB));
	//(clk, read_rega, read_regb, write_reg, write_data, rf_we, rsa, rsb)
	rf u2 (.clk(clk), .read_rega(ir[19:16]), .read_regb(outB), .write_reg(ir[23:20]), .write_data(outW), .rf_we(rf_we), .rsa(rsa), .rsb(rsb));
	ctrl u3 (.clk(clk), .rst_f(rst_f), .opcode(ir[31:28]), .mm(ir[27:24]), .stat(outS), .rf_we(rf_we), .alu_op(alu_op), .wb_sel(wb_sel), .rd_sel(rd_sel), .br_sel(br_sel), .pc_rst(pc_rst), .pc_write(pc_write), .pc_sel(pc_sel), .ir_load(ir_load), .dm_we(dm_we), .mm_sel(mm_sel));
	statreg u4 (.clk(clk), .in(cc), .enable(stat_en), .out(outS));
	mux32 u5 (.in_a(temp), .in_b(alu_result), .sel(wb_sel), .out(outW));
	alu u6 (.clk(clk), .rsa(rsa), .rsb(rsb), .imm(ir[15:0]), .alu_op(alu_op), .alu_result(alu_result), .stat(cc), .stat_en(stat_en));

  	pc u7 (.clk(clk), .br_addr(br_addr), .pc_sel(pc_sel), .pc_write(pc_write), .pc_rst(pc_rst), .pc_out(pc_out));
	br u8 (.pc_inc(pc_out), .imm(ir[15:0]), .br_sel(br_sel), .br_addr(br_addr));
	ir u9 (.clk(clk), .ir_load(ir_load), .read_data(read_data), .instr(ir));
	im u10 (.read_addr(pc_out), .read_data(read_data));

	dm u11 (.read_addr(outMx), .write_addr(outMx), .write_data(rsb), .dm_we(dm_we), .read_data(temp));
	mux16 u12 (.in_a(alu_result[31:16]), .in_b(ir[15:0]), .sel(mm_sel), .out(outMx));

// put a $monitor statement here.  
initial

	
	 $monitor ($time,,," IR: %h, PC: %h, R1=%h, R2=%h, R3=%h, R4=%h, R5=%h, ALU_OP=%b, BR_SEL=%b, PC_WRITE=%b, PC_SEL=%b, ALU_RESULT=%b, CC=%b, PC_SEL=%b", ir, pc_out, u2.ram_array[1], u2.ram_array[2], u2.ram_array[3], u2.ram_array[4], u2.ram_array[5], alu_op, br_sel, pc_write, pc_sel, alu_result, outS, pc_sel);
	




endmodule


