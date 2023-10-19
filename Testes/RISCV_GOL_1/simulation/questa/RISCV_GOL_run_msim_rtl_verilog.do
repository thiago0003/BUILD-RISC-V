transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/martins/Documents/RISCV_GOL_1 {/home/martins/Documents/RISCV_GOL_1/RISCV.sv}
vlog -sv -work work +incdir+/home/martins/Documents/RISCV_GOL_1 {/home/martins/Documents/RISCV_GOL_1/top.sv}
vlog -sv -work work +incdir+/home/martins/Documents/RISCV_GOL_1 {/home/martins/Documents/RISCV_GOL_1/vga.sv}
vlog -sv -work work +incdir+/home/martins/Documents/RISCV_GOL_1 {/home/martins/Documents/RISCV_GOL_1/mem.sv}

