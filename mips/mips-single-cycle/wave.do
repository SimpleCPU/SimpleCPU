onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {clock and reset} -radix hexadecimal /top_tb/T1/clk
add wave -noupdate -expand -group {clock and reset} -radix hexadecimal /top_tb/T1/reset
add wave -noupdate -expand -group pc -radix hexadecimal /top_tb/T1/curr_pc_top
add wave -noupdate -expand -group pc -radix hexadecimal /top_tb/T1/next_pc_top
add wave -noupdate -expand -group pc -radix hexadecimal /top_tb/T1/next_seq_pc_top
add wave -noupdate -expand -group pc -radix hexadecimal /top_tb/T1/next_jmp_pc_top
add wave -noupdate -expand -group pc -radix hexadecimal /top_tb/T1/next_beq_pc_top
add wave -noupdate -expand -group pc -radix hexadecimal /top_tb/T1/next_brn_eq_pc_top
add wave -noupdate -expand -group instr -radix hexadecimal /top_tb/T1/instr_top
add wave -noupdate -expand -group instr -radix hexadecimal /top_tb/T1/funct_top
add wave -noupdate -expand -group instr -radix hexadecimal /top_tb/T1/op_top
add wave -noupdate -expand -group instr /top_tb/T1/sign_ext_top
add wave -noupdate -expand -group instr /top_tb/T1/is_r_type_top
add wave -noupdate -expand -group instr /top_tb/T1/is_i_type_top
add wave -noupdate -expand -group instr /top_tb/T1/is_j_type_top
add wave -noupdate -expand -group control /top_tb/T1/reg_src_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/reg_dst_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/jump_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/branch_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/mem_read_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/mem_to_reg_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/alu_op_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/mem_wr_top
add wave -noupdate -expand -group control /top_tb/T1/alu_src_top
add wave -noupdate -expand -group control -radix hexadecimal /top_tb/T1/reg_wr_top
add wave -noupdate -expand -group control /top_tb/T1/sign_ext_top
add wave -noupdate -expand -group control /top_tb/T1/use_link_reg_top
add wave -noupdate -expand -group alu -radix hexadecimal /top_tb/T1/r_data_p1_top
add wave -noupdate -expand -group alu -radix hexadecimal /top_tb/T1/r_data_p2_top
add wave -noupdate -expand -group alu /top_tb/T1/n_top
add wave -noupdate -expand -group alu -radix hexadecimal /top_tb/T1/res_alu_top
add wave -noupdate -expand -group rf -radix hexadecimal /top_tb/T1/rd_top
add wave -noupdate -expand -group rf -radix hexadecimal /top_tb/T1/rs_top
add wave -noupdate -expand -group rf -radix hexadecimal /top_tb/T1/rt_top
add wave -noupdate -expand -group rf -radix hexadecimal /top_tb/T1/r_data_p1_top
add wave -noupdate -expand -group rf -radix hexadecimal /top_tb/T1/r_data_p2_rf_top
add wave -noupdate -expand -group rf -radix hexadecimal /top_tb/T1/wr_data_rf_top
add wave -noupdate -expand -group rf /top_tb/T1/rs_dec_top
add wave -noupdate -expand -group rf -radix hexadecimal /top_tb/T1/rd_dec_top
add wave -noupdate -radix hexadecimal /top_tb/T1/sign_imm_top
add wave -noupdate -radix hexadecimal /top_tb/T1/target_top
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/opr_a_alu_i
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/opr_b_alu_i
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/op_alu_i
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/cin_alu
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/opr_b_negated_alu
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/adder_out_alu
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/carry_out_alu
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/shifter_out_alu
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/logical_out_alu
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/res_alu_o
add wave -noupdate -group {alu block} /top_tb/T1/A1/n_alu_o
add wave -noupdate -group {alu block} -radix hexadecimal /top_tb/T1/A1/z_alu_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/alu_op_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/alu_src_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/branch_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/controls
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/instr_funct_ctl_i
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/instr_op_ctl_i
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/jump_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/mem_read_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/mem_to_reg_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/mem_wr_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/reg_dst_ctl_o
add wave -noupdate -group {control block} -radix hexadecimal /top_tb/T1/C1/reg_wr_ctl_o
add wave -noupdate -group {control block} /top_tb/T1/C1/sign_ext_ctl_o
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/clk
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/reset
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/r_reg_p1_rf_i
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/r_data_p1
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/r_data_p1_rf_o
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/r_reg_p2_rf_i
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/r_data_p2
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/r_data_p2_rf_o
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/w_reg_rf_i
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/w_en_rf_i
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/w_data_rf_i
add wave -noupdate -expand -group {rf block} -radix hexadecimal /top_tb/T1/R1/reg_file
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/funct_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/instr_dec_i
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/is_i_type_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/is_j_type_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/is_r_type_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/op_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/rd_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/rs_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/rt_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/shamt_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/sign_imm_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/target_dec_o
add wave -noupdate -expand -group {decode block} -radix hexadecimal /top_tb/T1/D1/use_link_reg_dec_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {53 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 282
configure wave -valuecolwidth 187
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
WaveRestoreZoom {0 ps} {110 ps}
