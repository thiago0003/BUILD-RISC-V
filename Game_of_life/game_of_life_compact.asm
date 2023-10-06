evolve:
        sw      a0,-52(s0)
        sw      a1,-56(s0)
        li      s5,0
        li      s8,30
        li      s4,30
        li      s3,0
        j       .L2
.L22:
        li      s1,0
        j       .L3
.L21:
        li      s7,0
        addi    s6,s3,-1
        j       .L4
.L16:
        li      s9,0
        bge     s6,zero,.L5
        add     s10,s6,s4
        j       .L6
.L5:
        bne     s6,s4,.L7
        li      s10,0
        j       .L6
.L7:
        mv      s10,s6
.L6:
        li      s2,0
        j       .L8
.L9:
        add     s9,s9,s4
        addi    s2,s2,1
.L8:
        blt     s2,s10,.L9
        addi    s2,s1,-1
        j       .L10
.L15:
        bge     s2,zero,.L11
        add     s10,s2,s8
        j       .L12
.L11:
        bne     s2,s8,.L13
        li      s10,0
        j       .L12
.L13:
        mv      s10,s2
.L12:
        add     s10,s9,s10
        mv      a5,s10
        slli    a5,a5,2
        lw      a4,-52(s0)
        add     a5,a4,a5
        lw      a5,0(a5)
        beq     a5,zero,.L14
        addi    s7,s7,1
.L14:
        addi    s2,s2,1
.L10:
        addi    a5,s1,1
        ble     s2,a5,.L15
        addi    s6,s6,1
.L4:
        addi    a5,s3,1
        ble     s6,a5,.L16
        add     s2,s5,s1
        mv      a5,s2
        slli    a5,a5,2
        lw      a4,-52(s0)
        add     a5,a4,a5
        lw      a5,0(a5)
        beq     a5,zero,.L17
        addi    s7,s7,-1
.L17:
        li      a5,3
        beq     s7,a5,.L18
        li      a5,2
        bne     s7,a5,.L19
        mv      a5,s2
        slli    a5,a5,2
        lw      a4,-52(s0)
        add     a5,a4,a5
        lw      a5,0(a5)
        beq     a5,zero,.L19
.L18:
        li      a3,1
        j       .L20
.L19:
        li      a3,0
.L20:
        mv      a5,s2
        slli    a5,a5,2
        lw      a4,-56(s0)
        add     a5,a4,a5
        mv      a4,a3
        sw      a4,0(a5)
        addi    s1,s1,1
.L3:
        blt     s1,s8,.L21
        add     s5,s5,s4
        addi    s3,s3,1
.L2:
        blt     s3,s4,.L22
        li      s5,0
        li      s3,0
        j       .L23
.L26:
        li      s1,0
        j       .L24
.L25:
        add     a5,s5,s1
        slli    a5,a5,2
        lw      a4,-56(s0)
        add     a4,a4,a5
        add     a5,s5,s1
        slli    a5,a5,2
        lw      a3,-52(s0)
        add     a5,a3,a5
        lw      a4,0(a4)
        sw      a4,0(a5)
        addi    s1,s1,1
.L24:
        blt     s1,s8,.L25
        add     s5,s5,s4
        addi    s3,s3,1
.L23:
        blt     s3,s4,.L26
        nop
        nop
        jr      ra
main:
        addi    sp,sp,-16
        sw      ra,12(sp)
        sw      s0,8(sp)
        addi    s0,sp,16
        li      t0,-8192
        addi    t0,t0,992
        add     sp,sp,t0
.L28:
        li      a5,-8192
        addi    a5,a5,992
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,-4096
        addi    a5,a5,496
        addi    a5,a5,-16
        add     a5,a5,s0
        mv      a1,a4
        mv      a0,a5
        call    evolve
        j       .L28