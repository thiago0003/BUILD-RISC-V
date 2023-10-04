transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/martins/Documents/BUILD-RISC-V/RISC-V {/home/martins/Documents/BUILD-RISC-V/RISC-V/RISCV.sv}

