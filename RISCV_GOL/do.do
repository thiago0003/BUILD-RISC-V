set top_level t_top
vdel -all -lib work
vlib work
vmap work work
vlog -work work *.v *.sv
vsim work.$top_level
add wave -radix hexadecimal sim:/$top_level/dut/*
configure wave -shortnames 1
#run -all
run 160 ns
wave zoom full