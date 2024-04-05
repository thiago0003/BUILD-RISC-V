main:
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        sw      s1,20(sp)
        sw      s2,16(sp)
        sw      s3,12(sp)
        sw      s4,8(sp)
        addi    s0,sp,32
        mv      a2,ra
        li      s1,0
        li      s2,8
        li      a4,5
        li      a3,3
        mv      a5,s3
        add a5, a4, a3

        mv      s3,a5
        bne     s2,s3,.L3
        addi    s1,s1,1
        li      s2,0
        li      a4,1
        li      a3,8
        mv      a5,s2
        addi a5, a4, a3

        mv      s2,a5
        li      a5,9
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      s2,0
        li      a4,5
        li      a3,3
        mv      a5,s2
        sub a5, a4, a3

        mv      s2,a5
        li      a5,2
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      s2,0
        li      a4,5
        li      a3,4
        mv      a5,s2
        andi a5, a4, a3

        mv      s2,a5
        li      a5,4
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      s2,0
        li      a4,5
        li      a3,2
        mv      a5,s2
        or a5, a4, a3

        mv      s2,a5
        li      a5,7
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      a5,4
        li      a4,2
        slli a5, a5, a4

        mv      s2,a5
        li      a5,16
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      s2,8
        li      a4,16
        li      a3,3
        mv      a5,s2
        srli a5, a4, a3

        mv      s2,a5
        li      a5,2
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      a5,4096
        addi    a5,a5,564
        auipc a5, a5

        mv      s2,a5
        li      a5,19087360
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      s3,0
        li      a5,1263591424
        addi    s2,a5,921
        mv      a5,s3
        xor a5, s2, s2

        mv      s3,a5
        bne     s3,zero,.L3
        addi    s1,s1,1
        li      a5,727375872
        addi    s3,a5,921
        li      a5,1264246784
        addi    s4,a5,921
        sltiu a5, s3, s4

        mv      s2,a5
        li      a5,1
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      a5,1264246784
        addi    s3,a5,921
        li      a5,727375872
        addi    s4,a5,921
        sltu a5, s3, s4

        mv      s2,a5
        li      a5,1
        bne     s2,a5,.L3
        addi    s1,s1,1
        li      a5,4096
        addi    s2,a5,564
        mv      a5,a2
        mv      s3,a5
        mv      a5,s2
        add     a5,s3,a5
        slli    s3,a5,2
        jal a5, s2 

        mv      s4,a5
        bne     s3,s4,.L3
        addi    s1,s1,1
.L3:
        mv      a5,s1
        mv      a0,a5
        lw      ra,28(sp)
        lw      s0,24(sp)
        lw      s1,20(sp)
        lw      s2,16(sp)
        lw      s3,12(sp)
        lw      s4,8(sp)
        addi    sp,sp,32
        jr      ra