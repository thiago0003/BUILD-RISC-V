	li t0, 0
	li t1, 300
loop:
	lw t2, 0(t0)
	addi t2, t2, 1
	sw t2, 0(t0)
	addi t0, t0, 4
	bge t0, t1, frame
	j loop
frame: 
	li t0, 0
	j loop
