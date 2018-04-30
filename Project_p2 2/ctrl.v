// ECE:3350 SISC computer project
// finite state machine

`timescale 1ns/100ps

module ctrl (clk, rst_f, opcode, mm, stat, rf_we, alu_op, wb_sel, rd_sel, br_sel, pc_rst, pc_write, pc_sel, ir_load, dm_we, mm_sel);

  /* TODO: Declare the ports listed above as inputs or outputs */
  input clk, rst_f, opcode;
  input [3:0] opcode, mm, stat;
  output  rf_we, wb_sel;
  output [1:0] alu_op;
  reg  rf_we, wb_sel; 
  reg [1:0] alu_op;
  //part 2, start from port rd_sel, there are six new parameters 
  output br_sel, pc_rst, pc_write, pc_sel, rd_sel, ir_load, dm_we, mm_sel;
  reg br_sel, pc_rst, pc_write, pc_sel, rd_sel, ir_load, dm_we, mm_sel;
  
  // states
  parameter start0 = 0, start1 = 1, fetch = 2, decode = 3, execute = 4, mem = 5, writeback = 6;
   
  // opcodes
  parameter NOOP = 0, LOD = 1, STR = 2, SWP = 3, BRA = 4, BRR = 5, BNE = 6, BNR = 7, ALU_OP = 8, HLT=15;
	
  // addressing modes
  parameter am_imm = 8;

  // state registers
  reg [2:0]  present_state, next_state;

  initial
    present_state = start0;

  /* TODO: Write a sequential procedure that progresses the fsm to the next state on the
       positive edge of the clock, OR resets the state to 'start1' on the negative edge
       of rst_f. Notice that the computer is reset when rst_f is low, not high. */

	always @ (present_state, posedge clk or negedge rst_f) begin
	if (rst_f == 0)
	begin
		pc_rst <= 1'b1;
		present_state <= start1;
	end
	else 
	begin
		pc_rst <= 1'b0;
		present_state <= next_state;
	end
	end


  
  /* TODO: Write a combination procedure that determines the next state of the fsm. */

		always @(*) 
		begin 
			if (rst_f == 0)
				next_state <= start1;
			else 
				case (present_state)
				start1: if (rst_f) next_state <= fetch; else next_state <= start1;
				fetch: next_state <= decode;
				decode: next_state <= execute;
				execute: next_state <= mem;
				mem: next_state <= writeback;
				writeback: next_state <= fetch;
				endcase
			end 
				


  /* TODO: Generate outputs based on the FSM states and inputs. For Parts 2, 3 and 4 you will
       add the new control signals herPrimaryworkModulectrle. */
		always @ (present_state)
	begin
	 begin
	rd_sel <= 1;
	ir_load <= 1'b0;
	pc_write <= 1'b0;
	pc_sel <= 1'b1;
	br_sel <= 1'b0;
	rf_we <= 1'b0;
	alu_op <= 2'b10;
	wb_sel <= 1'b1;
	dm_we <= 0;
	mm_sel <= 0;
	end
	if (opcode == NOOP)begin
	pc_sel <= 0;
	end 
	case(present_state)
	//start1:
		
	fetch: 
		begin 
			pc_sel <= 1'b0;
			pc_write <= 1'b1;
			ir_load <= 1'b1;
			
			if ((opcode == LOD) || (opcode == STR))
				br_sel <= 0;
		end
	decode: 
	begin
		if (opcode == BRA || opcode == BNE)
			br_sel <= 1;
		else 
			br_sel <= 0;
			
		if ((mm == 0) && (opcode == BNE || opcode == BNR || opcode == BRA || opcode == BRR))
			pc_write <= 1;
		else if (((stat & mm) != 0) && (opcode == BRA || opcode == BRR))
			pc_write <= 1;
		else if (((stat & mm) == 0) && (opcode == BNE || opcode == BNR))
			pc_write <= 1;
		else 
			pc_write <= 0;

		if (opcode == LOD)
			rd_sel <= 0;
		else
			rd_sel <= 1;
		
	end 
	
		
	execute: 
		begin
		rf_we <= 1'b0;
		alu_op <= 2'b10;

		if (opcode == ALU_OP)
			alu_op[1] <= 0; 

		if (mm == 4'b1000)
			alu_op[0] <= 1'b1;


		if (((opcode == LOD) || (opcode == STR)) && (mm == 4'b0000))
			begin
				alu_op <= 2'b10; // 1
				mm_sel <= 1; //0
			end
		else if (((opcode == LOD) || (opcode == STR)) && (mm == 4'b1000))
			begin
				alu_op <= 2'b11; //0
				mm_sel <= 0; //1
			end

		if (opcode == STR)
			begin
				rf_we <= 0;
				dm_we <= 1;
				rd_sel <= 0;
			end
		end
	mem: 
		begin
		if (opcode == 8)
			rf_we <= 1'b1;
			
		else 
			rf_we <= 1'b0;
		alu_op <= 2'b10;
		if (mm == 4'b1000)
			alu_op[0] <= 1'b1;
		if (opcode == LOD)
			wb_sel <= 1;
		
		end 
	writeback: 
	begin 
		if (opcode == LOD)
			rf_we <= 1;
		if (opcode == 8)
			rf_we <= 1'b1;
		else 
			rf_we <= 1'b0;
		alu_op <= 2'b10;
		  
	end
	default: 
		begin
		rd_sel <= 0;
	ir_load <= 1'b0;
	pc_write <= 1'b0;
	pc_sel <= 1'b1;
	br_sel <= 1'b0;
	rf_we <= 1'b0;
	alu_op <= 2'b10;
	wb_sel <= 1'b1; 
		end
	endcase
	end
/*- alu_op (2 bits): This control line allows the control unit to override the
   *        usual function of the ALU to perform specific operations. 
		
	When bit 1 is set to 1, the control unit is telling the ALU that the instruction being
   *        executed is not an arithmetic operation, and thus, the status code should
   *        not be saved to the status register. For loads and stores, though, the ALU
   *        may still be needed. 
	When bit 0 is set to 1, the immediate value is used
   *        as the second operand to the adder, rather than RB.
   *
*/

// Halt on HLT instruction
  
  always @ (opcode)
  begin
    if (opcode == HLT)
    begin 
      #5 $display ("Halt."); //Delay 5 ns so $monitor will print the halt instruction
      $stop;
    end
  end
    
  
endmodule 