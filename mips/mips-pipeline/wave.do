onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {clk and reset} -radix hexadecimal /top_tb/T1/clk
add wave -noupdate -expand -group {clk and reset} -radix hexadecimal /top_tb/T1/reset
add wave -noupdate -expand -group FETCH -radix hexadecimal /top_tb/T1/stall_fetch
add wave -noupdate -expand -group FETCH -radix hexadecimal /top_tb/T1/instr_pc_reg_fetch
add wave -noupdate -expand -group FETCH -radix hexadecimal /top_tb/T1/curr_pc_pc_reg_fetch
add wave -noupdate -expand -group FETCH -radix hexadecimal /top_tb/T1/next_pc_fetch_iss
add wave -noupdate -expand -group FETCH -radix hexadecimal /top_tb/T1/next_seq_pc_pc_reg_fetch
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/valid_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/stall_iss
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/next_pc_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/next_beq_pc_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/next_beq_pc_carry_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/is_i_type_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/is_j_type_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/is_r_type_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/instr_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/op_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/funct_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/shamt_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/target_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/reg_src_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/reg_dst_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/jump_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/branch_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/mem_read_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/mem_to_reg_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal -childformat {{{/top_tb/T1/alu_op_iss_ex[5]} -radix hexadecimal} {{/top_tb/T1/alu_op_iss_ex[4]} -radix hexadecimal} {{/top_tb/T1/alu_op_iss_ex[3]} -radix hexadecimal} {{/top_tb/T1/alu_op_iss_ex[2]} -radix hexadecimal} {{/top_tb/T1/alu_op_iss_ex[1]} -radix hexadecimal} {{/top_tb/T1/alu_op_iss_ex[0]} -radix hexadecimal}} -subitemconfig {{/top_tb/T1/alu_op_iss_ex[5]} {-height 16 -radix hexadecimal} {/top_tb/T1/alu_op_iss_ex[4]} {-height 16 -radix hexadecimal} {/top_tb/T1/alu_op_iss_ex[3]} {-height 16 -radix hexadecimal} {/top_tb/T1/alu_op_iss_ex[2]} {-height 16 -radix hexadecimal} {/top_tb/T1/alu_op_iss_ex[1]} {-height 16 -radix hexadecimal} {/top_tb/T1/alu_op_iss_ex[0]} {-height 16 -radix hexadecimal}} /top_tb/T1/alu_op_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/mem_wr_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal -childformat {{{/top_tb/T1/alu_src_iss_ex[2]} -radix hexadecimal} {{/top_tb/T1/alu_src_iss_ex[1]} -radix hexadecimal} {{/top_tb/T1/alu_src_iss_ex[0]} -radix hexadecimal}} -subitemconfig {{/top_tb/T1/alu_src_iss_ex[2]} {-height 16 -radix hexadecimal} {/top_tb/T1/alu_src_iss_ex[1]} {-height 16 -radix hexadecimal} {/top_tb/T1/alu_src_iss_ex[0]} {-height 16 -radix hexadecimal}} /top_tb/T1/alu_src_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/reg_wr_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/sign_ext_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/sign_imm_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/sign_ext_iss
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/rd_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/rs_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/rt_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/r_data_p1_rf_iss_ex
add wave -noupdate -expand -group ISSUE -radix hexadecimal /top_tb/T1/r_data_p2_rf_iss_ex
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/valid_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/flush_ex
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/alu_op_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/alu_src_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/reg_dst_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/mem_to_reg_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/mem_wr_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/reg_wr_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/sign_imm_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/rd_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/rs_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/rt_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/r_data_p1_alu_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/r_data_p1_rf_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/r_data_p2_alu_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/r_data_p2_rf_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/fwd_r_data_p1_alu_ex
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/fwd_r_data_p2_alu_ex
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/res_alu_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/n_ex_mem
add wave -noupdate -expand -group EXECUTE -radix hexadecimal /top_tb/T1/z_ex_mem
add wave -noupdate -group MEMORY -radix hexadecimal /top_tb/T1/valid_mem_wb
add wave -noupdate -group MEMORY -radix hexadecimal /top_tb/T1/mem_to_reg_mem_wb
add wave -noupdate -group MEMORY -radix hexadecimal /top_tb/T1/mem_wr_mem_wb
add wave -noupdate -group MEMORY -radix hexadecimal /top_tb/T1/reg_wr_mem_wb
add wave -noupdate -group MEMORY -radix hexadecimal /top_tb/T1/rd_mem_wb
add wave -noupdate -group MEMORY -radix hexadecimal /top_tb/T1/res_alu_mem_wb
add wave -noupdate -group MEMORY -radix hexadecimal /top_tb/T1/read_data_dmem_ram_mem_wb
add wave -noupdate -group WRITE-BACK -radix hexadecimal /top_tb/T1/valid_wb_ret
add wave -noupdate -group WRITE-BACK -radix hexadecimal /top_tb/T1/mem_to_reg_wb_ret
add wave -noupdate -group WRITE-BACK -radix hexadecimal /top_tb/T1/reg_wr_wb_ret
add wave -noupdate -group WRITE-BACK -radix hexadecimal /top_tb/T1/rd_wb_ret
add wave -noupdate -group WRITE-BACK -radix hexadecimal /top_tb/T1/res_alu_wb_ret
add wave -noupdate -group WRITE-BACK -radix hexadecimal /top_tb/T1/read_data_wb_ret
add wave -noupdate -group WRITE-BACK -radix hexadecimal /top_tb/T1/wr_data_rf_wb_ret
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/clk
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/r_data_p1
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/r_data_p1_rf_o
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/r_data_p2
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/r_data_p2_rf_o
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/r_reg_p1_rf_i
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/r_reg_p2_rf_i
add wave -noupdate -radix hexadecimal -childformat {{{/top_tb/T1/R1/reg_file[31]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[30]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[29]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[28]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[27]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[26]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[25]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[24]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[23]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[22]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[21]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[20]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[19]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[18]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[17]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[16]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[15]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[14]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[13]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[12]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[11]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[10]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[9]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[8]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[7]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[6]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[5]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[4]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[3]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[2]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[1]} -radix hexadecimal} {{/top_tb/T1/R1/reg_file[0]} -radix hexadecimal}} -expand -subitemconfig {{/top_tb/T1/R1/reg_file[31]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[30]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[29]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[28]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[27]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[26]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[25]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[24]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[23]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[22]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[21]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[20]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[19]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[18]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[17]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[16]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[15]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[14]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[13]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[12]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[11]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[10]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[9]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[8]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[7]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[6]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[5]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[4]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[3]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[2]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[1]} {-radix hexadecimal} {/top_tb/T1/R1/reg_file[0]} {-radix hexadecimal}} /top_tb/T1/R1/reg_file
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/reset
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/w_data_rf_i
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/w_en_rf_i
add wave -noupdate -radix hexadecimal /top_tb/T1/R1/w_reg_rf_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {580 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 325
configure wave -valuecolwidth 243
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
configure wave -timelineunits ns
update
WaveRestoreZoom {379 ps} {581 ps}
