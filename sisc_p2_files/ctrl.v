// ECE:3350 SISC computer project
// finite state machine

`timescale 1ns/100ps

module ctrl (clk, rst_f, opcode, mm, stat, rf_we, alu_op, wb_sel, rd_sel, br_sel, pc_rst, pc_write, pc_sel, ir_load);

  /* Declare the ports listed above as inputs or outputs.  Note that
     you will add signals for parts 2, 3, and 4. */
  
  input clk, rst_f;
  input [3:0] opcode, mm, stat;
  output reg rf_we, wb_sel, br_sel, rd_sel, pc_rst, pc_write, pc_sel, ir_load;
  output reg [1:0] alu_op;
  
  // br_sel: Controls whether to add the immediate value to PC+1
  // (relative branch, br_sel = 0) or to add it to 0 (absolute branch,
  // br_sel = 1).
  
  // state parameter declarations
  
  parameter start0 = 0, start1 = 1, fetch = 2, decode = 3, execute = 4, mem = 5, writeback = 6;
   
  // opcode paramenter declarations
  
  parameter NOOP = 0, LOD = 1, STR = 2, SWP = 3, BRA = 4, BRR = 5, BNE = 6, BNR = 7, ALU_OP = 8, HLT=15;

  // addressing modes
  
  parameter AM_IMM = 8;

  // state register and next state value
  
  reg [2:0]  present_state, next_state;

  // Initialize present state to 'start0'.
  
  initial
    present_state = start0;

  /* Clock procedure that progresses the fsm to the next state on the positive 
     edge of the clock, OR resets the state to 'start1' on the negative edge
     of rst_f. Notice that the computer is reset when rst_f is low, not high. */

  always @(posedge clk, negedge rst_f)
  begin
    if (rst_f == 1'b0)
      present_state <= start1;
    else
      present_state <= next_state;
  end
  
  /* Combinational procedure that determines the next state of the fsm. */

  always @(present_state, rst_f)
  begin
    case(present_state)
      start0:
        next_state = start1;
      start1:
	if (rst_f == 1'b0) 
          next_state = start1;
	else
          next_state = fetch;
      fetch:
        next_state = decode;
      decode:
        next_state = execute;
      execute:
        next_state = mem;
      mem:
        next_state = writeback;
      writeback:
        next_state = fetch;
      default:
        next_state = start1;
    endcase
  end
  
  /* TODO: Generate the rf_we, alu_op, wb_sel outputs based on the FSM states 
     and inputs. For Parts 2, 3 and 4 you will add the new control signals here. */

	// pc_write: When this control bit changes to 1, the selected value (either
    // the branch address or PC+1) is saved to pc_out and held there until
   // the next time pc_en is set to 1.

// Halt on HLT instruction
  
	always @(opcode)
	begin
		if (opcode == HLT)
		begin 
			#5 $display ("Halt."); //Delay 5 ns so $monitor will print the halt instruction
			$stop;
		end	
	end 
	
	always @ (present_state)
	begin
		pc_rst <= 1'b0;
		pc_write <= 1'b0;
		ir_load <= 1'b0;
		rd_sel <= 1'b0;
		pc_sel <= 1'b1;
		case(present_state)
		
			start1:
			begin
				pc_rst <= 1;
			end
			
			fetch: 
			begin 
				// pc_in <= pc_out + 1, ir_load, pc_out <= pc_in
				pc_sel <= 1'b0; // 1st - save current program counter
				pc_write <= 1'b1; // 2nd - saved to pc_out and held there until the next time pc_en is set
				ir_load <= 1'b1;
			end
			decode:
			begin 
				if (opcode == BRR || opcode == BNR)
					br_sel <= 1'b0;
				else
					br_sel <= 1'b1;
			end
			
			execute: 
			begin		
				if (mm == AM_IMM)
					alu_op[0] <= 1'b1;
				else 
					alu_op[0] <= 1'b0;
				
				if (opcode == ALU_OP)
					alu_op[1] <= 1'b0;
				else 
					alu_op[1] <= 1'b1;
					
				if ((mm == 0) && (opcode == BNE || opcode == BNR || opcode == BRA || opcode == BRR))
				begin
					// pc_sel <= 1'b1;
					pc_write <= 1'b1;
				end
				else if (((stat & mm) != 0) && (opcode == BRA || opcode == BRR))
				begin	
					// pc_sel <= 1'b1;
					pc_write <= 1'b1;
				end
				else if (((stat & mm) == 0) && (opcode == BNE || opcode == BNR))
				begin	
					// pc_sel <= 1'b1;
					pc_write <= 1'b1;
				end
				else 
				begin
					// pc_sel <= 1'b0;
					pc_write <= 1'b1;
				end
					
				if (opcode == STR || opcode == LOD)
				begin
					rd_sel <= 1'b1;
				end
					
				
					
			end
			
			mem: 
			begin
				if (opcode == ALU_OP ||| opcode == STR || opcode == LOD)
				begin
					wb_sel <= 1'b0;
				end
			end
			
			writeback: 
			begin 
				if ((opcode == STR || opcode == ALU_OP))
				begin
					//wb_sel <= 1'b0;
					rf_we <= 1'b1;
				end
			end
	
			default:
			begin 
				rf_we <= 1'b0;
				//alu_op <= 2'b10;
				wb_sel <= 1'b1; 

				alu_op[1] <= 1'b1;
				alu_op[0] <= 1'b0;
				br_sel <= 1'b1;
				pc_rst <= 1'b0;
				pc_write <= 1'b0;
				ir_load <= 1'b0;
	
			end
			
		endcase 
	end
    
  
endmodule
