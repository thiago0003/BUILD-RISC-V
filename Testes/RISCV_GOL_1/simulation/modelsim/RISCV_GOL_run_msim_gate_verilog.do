transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {/home/martins/intelFPGA_lite/22.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/cycloneive_ver
vmap cycloneive_ver ./verilog_libs/cycloneive_ver
vlog -vlog01compat -work cycloneive_ver {/home/martins/intelFPGA_lite/22.1std/quartus/eda/sim_lib/cycloneive_atoms.v}

if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {RISCV_GOL.vo}

vlog -sv -work work +incdir+/home/martins/Documents/RISCV_GOL_1 {/home/martins/Documents/RISCV_GOL_1/top.sv}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  riscv

add wave *
view structure
view signals
run -all
