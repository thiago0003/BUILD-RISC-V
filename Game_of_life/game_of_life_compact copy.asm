0x00000093	addi x1 x0 0	        addi x1, x0, 0
0x00000113	addi x2 x0 0	        addi x2, x0, 0
0x00000293	addi x5 x0 0	        addi x5, x0, 0
0x00000313	addi x6 x0 0	        addi x6, x0, 0
0x00000413	addi x8 x0 0	        addi x8, x0, 0
0x00000493	addi x9 x0 0	        addi x9, x0, 0
0x00000513	addi x10 x0 0	        addi x10, x0, 0
0x00000593	addi x11 x0 0	        addi x11, x0, 0
0x00000693	addi x13 x0 0	        addi x13, x0, 0
0x00000713	addi x14 x0 0	        addi x14, x0, 0
0x00000793	addi x15 x0 0	        addi x15, x0, 0
0x00000913	addi x18 x0 0	        addi x18, x0, 0
0x00000993	addi x19 x0 0	        addi x19, x0, 0
0x00000a13	addi x20 x0 0	        addi x20, x0, 0
0x00000a93	addi x21 x0 0	        addi x21, x0, 0
0x00000b13	addi x22 x0 0	        addi x22, x0, 0
0x00000b93	addi x23 x0 0	        addi x23, x0, 0
0x00000c13	addi x24 x0 0	        addi x24, x0, 0
0x00000c93	addi x25 x0 0	        addi x25, x0, 0
0x00000d13	addi x26 x0 0	        addi x26, x0, 0



   Code                 Basic                 
0xfc010113      addi x2,x2,0xffffffc0             addi    sp,sp,-64
0x02112e23      sw x1,0x0000003c(x2)              sw      ra,60(sp)
0x02812c23      sw x8,0x00000038(x2)              sw      s0,56(sp)
0x02912a23      sw x9,0x00000034(x2)              sw      s1,52(sp)
0x03212823      sw x18,0x00000030(x2)             sw      s2,48(sp)
0x03312623      sw x19,0x0000002c(x2)             sw      s3,44(sp)
0x03412423      sw x20,0x00000028(x2)             sw      s4,40(sp)
0x03512223      sw x21,0x00000024(x2)             sw      s5,36(sp)
0x03612023      sw x22,0x00000020(x2)             sw      s6,32(sp)
0x01712e23      sw x23,28(x2)                     sw      s7,28(sp)
0x01812c23      sw x24,24(x2)                     sw      s8,24(sp)
0x01912a23      sw x25,20(x2)                     sw      s9,20(sp)
0x01a12823      sw x26,16(x2)                     sw      s10,16(sp)
0x04010413      addi x8,x2,0x00000040             addi    s0,sp,64
0xfca42623      sw x10,0xffffffcc(x8)             sw      a0,-52(s0)
0xfcb42423      sw x11,0xffffffc8(x8)             sw      a1,-56(s0)
0x00000a93      addi x21,x0,0                     li      s5,0
0x01e00c13      addi x24,x0,30                    li      s8,30
0x01e00a13      addi x20,x0,30                    li      s4,30
0x00000993      addi x19,x0,0                     li      s3,0
0x1240006f      jal x0,0x00000124                 j       .L2
0x00000493      addi x9,x0,0                      li      s1,0
0x1100006f      jal x0,0x00000110                 j       .L3
0x00000b93      addi x23,x0,0                     li      s7,0
0xfff98b13      addi x22,x19,0xffffffff           addi    s6,s3,-1
0x08c0006f      jal x0,0x0000008c                 j       .L4
0x00000c93      addi x25,x0,0                     li      s9,0
0x000b5663      bge x22,x0,0x0000000c             bge     s6,zero,.L5
0x014b0d33      add x26,x22,x20                   add     s10,s6,s4
0x0140006f      jal x0,0x00000014                 j       .L6
0x014b1663      bne x22,x20,0x0000000c            bne     s6,s4,.L7
0x00000d13      addi x26,x0,0                     li      s10,0
0x0080006f      jal x0,0x00000008                 j       .L6
0x01600d33      add x26,x0,x22                    mv      s10,s6
0x00000913      addi x18,x0,0                     li      s2,0
0x00c0006f      jal x0,0x0000000c                 j       .L8
0x014c8cb3      add x25,x25,x20                   add     s9,s9,s4
0x00190913      addi x18,x18,1                    addi    s2,s2,1
0xffa94ce3      blt x18,x26,0xfffffff8            blt     s2,s10,.L9
0xfff48913      addi x18,x9,0xffffffff            addi    s2,s1,-1
0x0440006f      jal x0,0x00000044                 j       .L10
0x00095663      bge x18,x0,0x0000000c             bge     s2,zero,.L11
0x01890d33      add x26,x18,x24                   add     s10,s2,s8
0x0140006f      jal x0,0x00000014                 j       .L12
0x01891663      bne x18,x24,0x0000000c            bne     s2,s8,.L13
0x00000d13      addi x26,x0,0                     li      s10,0
0x0080006f      jal x0,0x00000008                 j       .L12
0x01200d33      add x26,x0,x18                    mv      s10,s2
0x01ac8d33      add x26,x25,x26                   add     s10,s9,s10
0x01a007b3      add x15,x0,x26                    mv      a5,s10
0x00279793      slli x15,x15,2                    slli    a5,a5,2
0xfcc42703      lw x14,0xffffffcc(x8)             lw      a4,-52(s0)
0x00f707b3      add x15,x14,x15                   add     a5,a4,a5
0x0007a783      lw x15,0(x15)                     lw      a5,0(a5)
0x00078463      beq x15,x0,0x00000008             beq     a5,zero,.L14
0x001b8b93      addi x23,x23,1                    addi    s7,s7,1
0x00190913      addi x18,x18,1                    addi    s2,s2,1
0x00148793      addi x15,x9,1                     addi    a5,s1,1
0xfb27dee3      bge x15,x18,0xffffffbc            ble     s2,a5,.L15
0x001b0b13      addi x22,x22,1                    addi    s6,s6,1
0x00198793      addi x15,x19,1                    addi    a5,s3,1
0xf767dae3      bge x15,x22,0xffffff74            ble     s6,a5,.L16
0x009a8933      add x18,x21,x9                    add     s2,s5,s1
0x012007b3      add x15,x0,x18                    mv      a5,s2
0x00279793      slli x15,x15,2                    slli    a5,a5,2
0xfcc42703      lw x14,0xffffffcc(x8)             lw      a4,-52(s0)
0x00f707b3      add x15,x14,x15                   add     a5,a4,a5
0x0007a783      lw x15,0(x15)                     lw      a5,0(a5)
0x00078463      beq x15,x0,0x00000008             beq     a5,zero,.L17
0xfffb8b93      addi x23,x23,0xffffffff           addi    s7,s7,-1
0x00300793      addi x15,x0,3                     li      a5,3
0x02fb8263      beq x23,x15,0x00000024            beq     s7,a5,.L18
0x00200793      addi x15,x0,2                     li      a5,2
0x02fb9263      bne x23,x15,0x00000024            bne     s7,a5,.L19
0x012007b3      add x15,x0,x18                    mv      a5,s2
0x00279793      slli x15,x15,2                    slli    a5,a5,2
0xfcc42703      lw x14,0xffffffcc(x8)             lw      a4,-52(s0)
0x00f707b3      add x15,x14,x15                   add     a5,a4,a5
0x0007a783      lw x15,0(x15)                     lw      a5,0(a5)
0x00078663      beq x15,x0,0x0000000c             beq     a5,zero,.L19
0x00100693      addi x13,x0,1                     li      a3,1
0x0080006f      jal x0,0x00000008                 j       .L20
0x00000693      addi x13,x0,0                     li      a3,0
0x012007b3      add x15,x0,x18                    mv      a5,s2
0x00279793      slli x15,x15,2                    slli    a5,a5,2
0xfc842703      lw x14,0xffffffc8(x8)             lw      a4,-56(s0)
0x00f707b3      add x15,x14,x15                   add     a5,a4,a5
0x00d00733      add x14,x0,x13                    mv      a4,a3
0x00e7a023      sw x14,0(x15)                     sw      a4,0(a5)
0x00148493      addi x9,x9,1                      addi    s1,s1,1
0xef84cae3      blt x9,x24,0xfffffef4             blt     s1,s8,.L21
0x014a8ab3      add x21,x21,x20                   add     s5,s5,s4
0x00198993      addi x19,x19,1                    addi    s3,s3,1
0xef49c0e3      blt x19,x20,0xfffffee0            blt     s3,s4,.L22
0x00000a93      addi x21,x0,0                     li      s5,0
0x00000993      addi x19,x0,0                     li      s3,0
0x0440006f      jal x0,0x00000044                 j       .L23
0x00000493      addi x9,x0,0                      li      s1,0
0x0300006f      jal x0,0x00000030                 j       .L24
0x009a87b3      add x15,x21,x9                    add     a5,s5,s1
0x00279793      slli x15,x15,2                    slli    a5,a5,2
0xfc842703      lw x14,0xffffffc8(x8)             lw      a4,-56(s0)
0x00f70733      add x14,x14,x15                   add     a4,a4,a5
0x009a87b3      add x15,x21,x9                    add     a5,s5,s1
0x00279793      slli x15,x15,2                    slli    a5,a5,2
0xfcc42683      lw x13,0xffffffcc(x8)             lw      a3,-52(s0)
0x00f687b3      add x15,x13,x15                   add     a5,a3,a5
0x00072703      lw x14,0(x14)                     lw      a4,0(a4)
0x00e7a023      sw x14,0(x15)                     sw      a4,0(a5)
0x00148493      addi x9,x9,1                      addi    s1,s1,1
0xfd84cae3      blt x9,x24,0xffffffd4             blt     s1,s8,.L25
0x014a8ab3      add x21,x21,x20                   add     s5,s5,s4
0x00198993      addi x19,x19,1                    addi    s3,s3,1
0xfd49c0e3      blt x19,x20,0xffffffc0            blt     s3,s4,.L26
0x00000013      addi x0,x0,0                      nop
0x00000013      addi x0,x0,0                      nop
0x03c12083      lw x1,0x0000003c(x2)              lw      ra,60(sp)
0x03812403      lw x8,0x00000038(x2)              lw      s0,56(sp)
0x03412483      lw x9,0x00000034(x2)              lw      s1,52(sp)
0x03012903      lw x18,0x00000030(x2)             lw      s2,48(sp)
0x02c12983      lw x19,0x0000002c(x2)             lw      s3,44(sp)
0x02812a03      lw x20,0x00000028(x2)             lw      s4,40(sp)
0x02412a83      lw x21,0x00000024(x2)             lw      s5,36(sp)
0x02012b03      lw x22,0x00000020(x2)             lw      s6,32(sp)
0x01c12b83      lw x23,28(x2)                     lw      s7,28(sp)
0x01812c03      lw x24,24(x2)                     lw      s8,24(sp)
0x01412c83      lw x25,20(x2)                     lw      s9,20(sp)
0x01012d03      lw x26,16(x2)                     lw      s10,16(sp)
0x04010113      addi x2,x2,0x00000040             addi    sp,sp,64
0x00008067      jalr x0,x1,0                      jr      ra
0xff010113      addi x2,x2,0xfffffff0             addi    sp,sp,-16
0x00112623      sw x1,12(x2)                      sw      ra,12(sp)
0x00812423      sw x8,8(x2)                       sw      s0,8(sp)
0x01010413      addi x8,x2,16                     addi    s0,sp,16
0x000007b7      lui x15,0                         lui     a5,%hi(new)
0x00078593      addi x11,x15,0                    addi    a1,a5,%lo(new)
0x000007b7      lui x15,0                         lui     a5,%hi(univ)
0x00078513      addi x10,x15,0                    addi    a0,a5,%lo(univ)
0x00000317      auipc x6,0                        call    evolve
0xdd8300e7      jalr x1,x6,0xfffffdd8        
0x00000230      jal x0,0xffffffe8                 j       .L28