onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sisc_tb/uut/u9/clk
add wave -noupdate /sisc_tb/uut/u9/instr
add wave -noupdate /sisc_tb/uut/u3/present_state
add wave -noupdate {/sisc_tb/uut/u11/ram_array[11]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[10]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[9]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[8]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[7]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[6]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[5]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[4]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[3]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[2]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[1]}
add wave -noupdate {/sisc_tb/uut/u11/ram_array[0]}
add wave -noupdate /sisc_tb/uut/u13/in_a
add wave -noupdate /sisc_tb/uut/u13/in_b
add wave -noupdate /sisc_tb/uut/u13/in_c
add wave -noupdate /sisc_tb/uut/u13/sel
add wave -noupdate /sisc_tb/uut/u13/out
add wave -noupdate /sisc_tb/uut/u1/in_a
add wave -noupdate /sisc_tb/uut/u1/in_b
add wave -noupdate /sisc_tb/uut/u1/in_c
add wave -noupdate /sisc_tb/uut/u1/sel
add wave -noupdate /sisc_tb/uut/u1/out
add wave -noupdate /sisc_tb/uut/u2/read_rega
add wave -noupdate /sisc_tb/uut/u2/read_regb
add wave -noupdate /sisc_tb/uut/u2/write_reg
add wave -noupdate /sisc_tb/uut/u2/write_data
add wave -noupdate /sisc_tb/uut/u2/rf_we
add wave -noupdate /sisc_tb/uut/u2/rsa
add wave -noupdate /sisc_tb/uut/u2/rsb
add wave -noupdate {/sisc_tb/uut/u2/ram_array[5]}
add wave -noupdate {/sisc_tb/uut/u2/ram_array[4]}
add wave -noupdate {/sisc_tb/uut/u2/ram_array[3]}
add wave -noupdate {/sisc_tb/uut/u2/ram_array[2]}
add wave -noupdate {/sisc_tb/uut/u2/ram_array[1]}
add wave -noupdate /sisc_tb/uut/u3/opcode
add wave -noupdate /sisc_tb/uut/u3/mm
add wave -noupdate /sisc_tb/uut/u3/stat
add wave -noupdate /sisc_tb/uut/u3/rf_we
add wave -noupdate /sisc_tb/uut/u3/wb_sel
add wave -noupdate /sisc_tb/uut/u3/alu_op
add wave -noupdate /sisc_tb/uut/u3/br_sel
add wave -noupdate /sisc_tb/uut/u3/pc_rst
add wave -noupdate /sisc_tb/uut/u3/pc_write
add wave -noupdate /sisc_tb/uut/u3/pc_sel
add wave -noupdate /sisc_tb/uut/u3/ir_load
add wave -noupdate /sisc_tb/uut/u3/dm_we
add wave -noupdate /sisc_tb/uut/u3/mm_sel
add wave -noupdate /sisc_tb/uut/u3/swap_reg_sel
add wave -noupdate /sisc_tb/uut/u3/rd_sel
add wave -noupdate /sisc_tb/uut/u3/present_state
add wave -noupdate /sisc_tb/uut/u5/in_a
add wave -noupdate /sisc_tb/uut/u5/in_b
add wave -noupdate /sisc_tb/uut/u5/sel
add wave -noupdate /sisc_tb/uut/u5/out
add wave -noupdate /sisc_tb/uut/u6/rsa
add wave -noupdate /sisc_tb/uut/u6/rsb
add wave -noupdate /sisc_tb/uut/u6/imm
add wave -noupdate /sisc_tb/uut/u6/alu_op
add wave -noupdate /sisc_tb/uut/u6/alu_result
add wave -noupdate /sisc_tb/uut/u7/br_addr
add wave -noupdate /sisc_tb/uut/u7/pc_out
add wave -noupdate /sisc_tb/uut/u7/pc_write
add wave -noupdate /sisc_tb/uut/u5/in_a
add wave -noupdate /sisc_tb/uut/u5/in_b
add wave -noupdate /sisc_tb/uut/u6/imm
add wave -noupdate /sisc_tb/uut/u5/sel
add wave -noupdate /sisc_tb/uut/u5/out
add wave -noupdate /sisc_tb/uut/u5/outreg
add wave -noupdate /sisc_tb/uut/u7/pc_in
add wave -noupdate /sisc_tb/uut/u3/switch
add wave -noupdate /sisc_tb/uut/u2/switch
add wave -noupdate /sisc_tb/uut/u3/swap_reg_sel
add wave -noupdate /sisc_tb/uut/u3/rd_sel
add wave -noupdate /sisc_tb/uut/u3/mm_sel
add wave -noupdate /sisc_tb/uut/u7/pc_sel
add wave -noupdate /sisc_tb/uut/u12/in_c
add wave -noupdate /sisc_tb/uut/u11/write_addr
add wave -noupdate /sisc_tb/uut/u11/write_data
add wave -noupdate /sisc_tb/uut/u11/dm_we
add wave -noupdate /sisc_tb/uut/u11/read_data
add wave -noupdate /sisc_tb/uut/u12/in_a
add wave -noupdate /sisc_tb/uut/u12/in_b
add wave -noupdate /sisc_tb/uut/u12/sel
add wave -noupdate /sisc_tb/uut/u12/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3384100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 224
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {6400 ps}
