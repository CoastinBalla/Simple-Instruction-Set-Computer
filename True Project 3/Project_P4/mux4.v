// ECE:3350 SISC processor project
// 16-bit mux

`timescale 1ns/100ps

module mux4 (in_a, in_b, in_c, sel, out);

  /*
   *  4-BIT MULTIPLEXER - mux16.v
   *
   *  Inputs:
   *   - in_a (4 bits): First input to the multiplexer. Chosen when sel = 0.
   *   - in_b (4 bits): Second input to the multiplexer. Chosen when sel = 1.
   *   - in_c (4 bits): Second input to the multiplexer. Chosen when sel = 2.
   *   - sel: Controls which input is seen at the output.
   *
   *  Outputs:
   *   - out (4 bits): Output from the multiplexer.
   *
   */
//mux4 u1 (.in_a(ir[23:20]), .in_b(ir[15:12]), .in_c(ir[19:16]) .sel(rd_sel), .out(outB));
  input  [3:0] in_a;
  input  [3:0] in_b;
  input  [3:0] in_c;
  input  [1:0] sel;
  output [3:0] out;

  reg    [3:0] out;
   
  always @ (in_a, in_b, in_c, sel)
  begin
    if (sel == 0)
      out = in_a;
    else if (sel == 1)
      out = in_b;
    else 
	out = in_c;
  end

endmodule 
