evolve:
        addi    sp,sp,-2032
        sw      ra,2028(sp)
        sw      s0,2024(sp)
        addi    s0,sp,2032
        addi    sp,sp,-1664
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        sw      a0,428(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        sw      a1,424(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        sw      a2,420(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a5,428(a5)
        sw      a5,-60(s0)
        sw      zero,-20(s0)
        sw      zero,-24(s0)
        j       .L2
.L24:
        sw      zero,-28(s0)
        j       .L3
.L23:
        sw      zero,-32(s0)
        lw      a5,-24(s0)
        addi    a5,a5,-1
        sw      a5,-36(s0)
        j       .L4
.L18:
        sw      zero,-40(s0)
        lw      a5,-36(s0)
        bge     a5,zero,.L5
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-36(s0)
        lw      a5,420(a5)
        add     a5,a4,a5
        j       .L6
.L5:
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-36(s0)
        lw      a5,420(a5)
        beq     a4,a5,.L7
        lw      a5,-36(s0)
        j       .L6
.L7:
        li      a5,0
.L6:
        sw      a5,-64(s0)
        sw      zero,-44(s0)
        j       .L9
.L10:
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-40(s0)
        lw      a5,420(a5)
        add     a5,a4,a5
        sw      a5,-40(s0)
        lw      a5,-44(s0)
        addi    a5,a5,1
        sw      a5,-44(s0)
.L9:
        lw      a4,-44(s0)
        lw      a5,-64(s0)
        blt     a4,a5,.L10
        lw      a5,-28(s0)
        addi    a5,a5,-1
        sw      a5,-48(s0)
        j       .L11
.L17:
        lw      a5,-48(s0)
        bge     a5,zero,.L12
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-48(s0)
        lw      a5,424(a5)
        add     a5,a4,a5
        j       .L13
.L12:
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-48(s0)
        lw      a5,424(a5)
        beq     a4,a5,.L14
        lw      a5,-48(s0)
        j       .L13
.L14:
        li      a5,0
.L13:
        sw      a5,-68(s0)
        lw      a4,-40(s0)
        lw      a5,-68(s0)
        add     a5,a4,a5
        sw      a5,-72(s0)
        lw      a5,-72(s0)
        slli    a5,a5,2
        lw      a4,-60(s0)
        add     a5,a4,a5
        lw      a5,0(a5)
        beq     a5,zero,.L16
        lw      a5,-32(s0)
        addi    a5,a5,1
        sw      a5,-32(s0)
.L16:
        lw      a5,-48(s0)
        addi    a5,a5,1
        sw      a5,-48(s0)
.L11:
        lw      a5,-28(s0)
        addi    a5,a5,1
        lw      a4,-48(s0)
        ble     a4,a5,.L17
        lw      a5,-36(s0)
        addi    a5,a5,1
        sw      a5,-36(s0)
.L4:
        lw      a5,-24(s0)
        addi    a5,a5,1
        lw      a4,-36(s0)
        ble     a4,a5,.L18
        lw      a4,-20(s0)
        lw      a5,-28(s0)
        add     a5,a4,a5
        slli    a5,a5,2
        lw      a4,-60(s0)
        add     a5,a4,a5
        lw      a5,0(a5)
        beq     a5,zero,.L19
        lw      a5,-32(s0)
        addi    a5,a5,-1
        sw      a5,-32(s0)
.L19:
        lw      a4,-32(s0)
        li      a5,3
        beq     a4,a5,.L20
        lw      a4,-32(s0)
        li      a5,2
        bne     a4,a5,.L21
        lw      a4,-20(s0)
        lw      a5,-28(s0)
        add     a5,a4,a5
        slli    a5,a5,2
        lw      a4,-60(s0)
        add     a5,a4,a5
        lw      a5,0(a5)
        beq     a5,zero,.L21
.L20:
        li      a3,1
        j       .L22
.L21:
        li      a3,0
.L22:
        lw      a4,-20(s0)
        lw      a5,-28(s0)
        add     a5,a4,a5
        li      a4,-4096
        addi    a4,a4,-16
        add     a4,a4,s0
        slli    a5,a5,2
        add     a5,a4,a5
        sw      a3,440(a5)
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L3:
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-28(s0)
        lw      a5,424(a5)
        blt     a4,a5,.L23
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-20(s0)
        lw      a5,420(a5)
        add     a5,a4,a5
        sw      a5,-20(s0)
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
.L2:
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-24(s0)
        lw      a5,420(a5)
        blt     a4,a5,.L24
        sw      zero,-20(s0)
        sw      zero,-52(s0)
        j       .L25
.L28:
        sw      zero,-56(s0)
        j       .L26
.L27:
        lw      a4,-20(s0)
        lw      a5,-56(s0)
        add     a5,a4,a5
        lw      a3,-20(s0)
        lw      a4,-56(s0)
        add     a4,a3,a4
        slli    a4,a4,2
        lw      a3,-60(s0)
        add     a4,a3,a4
        li      a3,-4096
        addi    a3,a3,-16
        add     a3,a3,s0
        slli    a5,a5,2
        add     a5,a3,a5
        lw      a5,440(a5)
        sw      a5,0(a4)
        lw      a5,-56(s0)
        addi    a5,a5,1
        sw      a5,-56(s0)
.L26:
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-56(s0)
        lw      a5,424(a5)
        blt     a4,a5,.L27
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-20(s0)
        lw      a5,420(a5)
        add     a5,a4,a5
        sw      a5,-20(s0)
        lw      a5,-52(s0)
        addi    a5,a5,1
        sw      a5,-52(s0)
.L25:
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a4,-52(s0)
        lw      a5,420(a5)
        blt     a4,a5,.L28
        nop
        nop
        addi    sp,sp,1664
        lw      ra,2028(sp)
        lw      s0,2024(sp)
        addi    sp,sp,2032
        jr      ra
main:
        addi    sp,sp,-2032
        sw      ra,2028(sp)
        sw      s0,2024(sp)
        addi    s0,sp,2032
        addi    sp,sp,-1600
        li      a5,30
        sw      a5,-20(s0)
        li      a5,30
        sw      a5,-24(s0)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        addi    a4,a5,488
        li      a5,4096
        addi    a5,a5,-496
        mv      a2,a5
        li      a1,0
        mv      a0,a4
        call    memset
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,568(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,680(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,692(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,712(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,716(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,724(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,772(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1048(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1056(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1096(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1108(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1112(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1136(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1164(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1172(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1176(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1228(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1260(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1264(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1324(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1360(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1380(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1428(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1476(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1500(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1548(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1564(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1612(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1768(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1880(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1892(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1912(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1916(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1924(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a5,a5,s0
        li      a4,1
        sw      a4,1972(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1848(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1840(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1800(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1788(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1784(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1760(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1732(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1724(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1720(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1668(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1632(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1572(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1536(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1468(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1420(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1348(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1332(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1284(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1128(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1016(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-1004(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-984(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-980(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-972(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-924(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-648(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-640(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-600(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-588(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-584(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-560(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-532(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-524(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-520(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-468(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-432(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-372(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-336(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-268(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-220(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-148(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-132(a5)
        li      a5,-4096
        addi    a5,a5,-16
        add     a4,a5,s0
        li      a5,4096
        add     a5,a4,a5
        li      a4,1
        sw      a4,-84(a5)
.L30:
        li      a5,-4096
        addi    a5,a5,488
        addi    a5,a5,-16
        add     a5,a5,s0
        lw      a2,-24(s0)
        lw      a1,-20(s0)
        mv      a0,a5
        call    evolve
        j       .L30