onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_testbench/dut/inst
add wave -noupdate /cpu_testbench/dut/instr/clk
add wave -noupdate /cpu_testbench/dut/instr/pc_ps
add wave -noupdate /cpu_testbench/dut/instr/pc_ns
add wave -noupdate /cpu_testbench/dut/cntrl_logic/imm12
add wave -noupdate /cpu_testbench/dut/mem/aa
add wave -noupdate /cpu_testbench/dut/mem/aw
add wave -noupdate /cpu_testbench/dut/mem/reg_dw
add wave -noupdate /cpu_testbench/dut/mem/alu_out
add wave -noupdate /cpu_testbench/reset
add wave -noupdate /cpu_testbench/dut/mem/mem_din
add wave -noupdate /cpu_testbench/dut/mem/mem_dout
add wave -noupdate /cpu_testbench/dut/mem/mr
add wave -noupdate /cpu_testbench/dut/mem/size
add wave -noupdate /cpu_testbench/dut/mem/mem/mem
add wave -noupdate -childformat {{{/cpu_testbench/dut/mem/register/reg_out[31]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[30]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[29]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[28]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[27]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[26]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[25]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[24]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[23]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[22]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[21]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[20]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[19]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[18]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[17]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[16]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[15]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[14]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[13]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[12]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[11]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[10]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[9]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[8]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[7]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[6]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[5]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[4]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[3]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[2]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[1]} -radix decimal} {{/cpu_testbench/dut/mem/register/reg_out[0]} -radix decimal}} -subitemconfig {{/cpu_testbench/dut/mem/register/reg_out[31]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[30]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[29]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[28]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[27]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[26]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[25]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[24]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[23]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[22]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[21]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[20]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[19]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[18]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[17]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[16]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[15]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[14]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[13]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[12]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[11]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[10]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[9]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[8]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[7]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[6]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[5]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[4]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[3]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[2]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[1]} {-radix decimal} {/cpu_testbench/dut/mem/register/reg_out[0]} {-radix decimal}} /cpu_testbench/dut/mem/register/reg_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50459481353 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 94
configure wave -valuecolwidth 395
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {48925820313 ps} {50582851563 ps}
