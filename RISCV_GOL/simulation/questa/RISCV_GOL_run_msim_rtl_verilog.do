transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/martins/Documents/BUILD-RISC-V/RISCV_GOL {/home/martins/Documents/BUILD-RISC-V/RISCV_GOL/pll.v}
vlog -vlog01compat -work work +incdir+/home/martins/Documents/BUILD-RISC-V/RISCV_GOL/db {/home/martins/Documents/BUILD-RISC-V/RISCV_GOL/db/pll_altpll.v}
vlog -sv -work work +incdir+/home/martins/Documents/BUILD-RISC-V/RISCV_GOL {/home/martins/Documents/BUILD-RISC-V/RISCV_GOL/top.sv}
vlog -sv -work work +incdir+/home/martins/Documents/BUILD-RISC-V/RISCV_GOL {/home/martins/Documents/BUILD-RISC-V/RISCV_GOL/mem.sv}

