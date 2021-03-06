# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./ALU.sv"
vlog "./ALU_bit.sv"
vlog "./AddandSub.sv"
vlog "./mux6_1.sv"
vlog "./checkZero.sv"
vlog "./execute.sv"
vlog "./movz.sv"
vlog "./RegIn.sv"
vlog "./regfile.sv"
vlog "./reg_file.sv"
vlog "./mux.sv"
vlog "./decoder.sv"
vlog "./math.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./eight_bits.sv"
vlog "./mem_reg.sv"
vlog "./pc_inst.sv"
vlog "./control.sv"
vlog "./cpu.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpu_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do cpu_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
