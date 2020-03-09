// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f);

  input clk, rst_f;
  // input [31:0] ir;
 
// declare all internal wires here

wire [31:0] alu_result, outMux32, rsa, rsb, ir, read_data, zero;
wire [1:0] alu_op;
wire [3:0] outMux4, stat, cc;
wire  stat_en, wb_sel, rf_we, rd_sel, clk, rst_f, pc_inc, br_sel, pc_sel, pc_write, ir_load;
wire [15:0] br_addr, pc_out;

// assign sel = 1'b0;
assign zero = 0;
 
// component instantiation goes here

	// mux4 u1 (.in_a(ir[23:20]), .in_b(ir[15:12]), .sel(sel), .out(outMux4)); 
	mux4 u1 (ir[15:12], ir[23:20], rd_sel, outMux4); 
	rf u2 (clk, ir[19:16], outMux4, ir[23:20], outMux32, rf_we, rsa, rsb); 
	// rf u2 (.clk(clk), .read_rega(ir[19:16]), .read_regb(outMux4), .write_reg(ir[23:20]), .write_data(outMux32), .rf_we(rf_we), .rsa(rsa), .rsb(rsb)); 
	// rf (clk, read_rega, read_regb, write_reg, write_data, rf_we, rsa, rsb);
	ctrl u3 (.clk(clk), .rst_f(rst_f), .opcode(ir[31:28]), .mm(ir[27:24]), .stat(stat), .rf_we(rf_we), .alu_op(alu_op), .wb_sel(wb_sel), .rd_sel(rd_sel), .br_sel(br_sel), .pc_rst(pc_rst), .pc_write(pc_write), .pc_sel(pc_sel), .ir_load(ir_load));
	// ctrl (clk, rst_f, opcode, mm, stat, rf_we, alu_op, wb_sel);
	statreg u4 (.clk(clk), .in(cc), .enable(stat_en), .out(stat)); 
	mux32 u5 (.in_a(alu_result), .in_b(zero), .sel(wb_sel), .out(outMux32)); 
	alu u6 (.clk(clk), .rsa(rsa), .rsb(rsb), .imm(ir[15:0]), .alu_op(alu_op), .alu_result(alu_result), .stat(cc), .stat_en(stat_en)); 
	br u7 (pc_out, ir[15:0], br_sel, br_addr);
	pc u8 (clk, br_addr, pc_sel, pc_write, pc_rst, pc_out);
	im u9 (pc_out, read_data);
	ir u10 (clk, ir_load, read_data, ir);

// put a $monitor statement here.  
initial

	
	 $monitor ($time,,," IR: %h, R1=%h, R2=%h, R3=%h, R4=%h, R5=%h, ALU_OP=%b, ALU_RESULT=%b, wb_sel=%b, rf_we=%b, mm=%b, rsa=%b, rsb=%b", ir, u2.ram_array[1], u2.ram_array[2], u2.ram_array[3], u2.ram_array[4], u2.ram_array[5], alu_op, alu_result, wb_sel, rf_we, ir[27:24], rsa, rsb);
	




endmodule

