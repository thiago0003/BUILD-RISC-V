#include <stdint.h>
// Making things easier...
#define uc unsigned char
#define uint_t unsigned 
#define ri register int32_t
#define rui register uint32_t

// To note, this is for ARM...
// #define curr_pc (__current_pc())
// This is for the others platforms (non-ARM)
#define curr_pc ((uint32_t) __builtin_return_address(0))

/* 
    fno-builtion make use of stacks(we dont want it)  [didnt work]
    Use of macros functions-based to avoid stack uses [worked    ]
    compiling asm function
    https://gcc.gnu.org/onlinedocs/gcc/extensions-to-the-c-language-family/how-to-use-inline-assembly-language-in-c-code.html
*/

#define u_test_add() ({     \
    ri exp = 8;             \
    ri c;                   \
    asm volatile(           \
    "add %0, %1, %2\n\t"    \
    : "+r" (c)              \
    : "r"  (5), "r"  (3));  \
    if(exp != c) goto test_failed;\
})   

#define u_test_addi(void) ({     \
    ri c=0;                 \
    asm volatile(           \
    "addi %0, %1, %2\n\t"    \
    : "+r" (c)              \
    : "r"  (1), "r"  (8));  \
    if(9 != c) goto test_failed;\
})   

#define u_test_sub(void)({  \
    ri c=0;                 \
    asm volatile(           \
    "sub %0, %1, %2\n\t"    \
    : "+r" (c)              \
    : "r"  (5), "r"  (3));  \
    if(2 != c) goto test_failed;\
})

#define u_test_andi(void)({ \
    ri c=0;                 \
    asm volatile(           \
    "andi %0, %1, %2\n\t"   \
    : "+r" (c)              \
    : "r"  (5), "r"  (4));  \
    if(4 != c) goto test_failed;\
})

#define u_test_or(void)({   \
    ri c=0;                 \
    asm volatile(           \
    "or %0, %1, %2\n\t"     \
    : "+r" (c)              \
    : "r"  (5), "r"  (2));  \
    if(7 != c) goto test_failed;\
})

#define u_test_ori(void)({  \
    ri exp = 7;             \
    ri c=0;                 \
    asm volatile(           \
    "ori %0, %1, %2\n\t"    \
    : "=r" (c)              \
    : "r"  (5), "r"  (4));  \
    if(4 != c) goto test_failed;\
})


#define u_test_slli(void)({ \
    ri c=0;                 \
    asm volatile(           \
    "slli %0, %1, %2\n\t"   \
    : "=r" (c)              \
    : "r"  (4), "r"  (2));  \
    if(16 != c) goto test_failed;\
})

#define u_test_srli(void)({  \
    ri c=8;                 \
    asm volatile(           \
    "srli %0, %1, %2\n\t"    \
    : "+r" (c)              \
    : "r"  (16), "r"  (3));  \
    if(2 != c) goto test_failed;\
})
// #AUIPC -> Rd = imm[31:12]<<12
    /*GET PC = __builtin_return_address is it correct ? */
#define u_test_auipc(void)({    \
    ri res;                     \
    const rui imm=0x1234;             \
    const rui pc = curr_pc;\
    const rui exp = imm<<12; \ 
    asm volatile(               \
    "auipc %0, %1\n\t"          \
    : "=r" (res)                \
    : "r"  (imm));              \
    if(res != exp) goto test_failed;\
})
// #TODO: how ?? i need memo. address
// #define u_test_lw(void)({  \
//     ri exp = 5;             \
//     ri c=0;                 \
//     asm volatile(           \
//     "lw %0, 0(%1)\n\t"    \
//     : "+r" (c)              \
//     : "r"  (&exp));  \
//     if(5 != c) goto test_failed;\
// })

// #TODO: how ?? i need memo. address
// #define u_test_sw(void)({  \
//     ri exp = 10;             \
//     ri c=0;                 \
//     asm volatile(           \
//     "sw %1, 0(%0)\n\t"    \
//     : "+r" (&c)              \
//     : "r"  (exp));  \
//     if(10 != exp) goto test_failed;\
// })

// #TODO: how ?? i need memo. address
// #define u_test_lui(void)({  \
//     ri exp = 65540;             \
//     ri c=0;                 \
//     asm volatile(           \
//     "lui %0, %1\n\t"    \
//     : "+r" (c)              \
//     : "r"  (c));  \
//     if(65540 != c) goto test_failed;\
// })

#define u_test_xor(void)({  \
    rui exp = 7;            \
    rui c=0;                \
    rui a = 0x4B50E399;     \
    asm volatile(           \
    "xor %0, %1, %2\n\t"    \
    : "+r" (c)              \
    : "r"  (a), "r"  (a));  \
    if(0 != c) goto test_failed;\
})
// #TODO: how ?? i need memo. address (load byte unsigned)
#define u_test_lbu(void)({  \
    ri exp = 3;             \
    ri c=0;                 \
    asm volatile(           \
    "lbu %0, 0(%1)\n\t"    \
    : "+r" (c)              \
    : "r"  (&exp));  \
    if(3 != c) goto test_failed;\
})
//  Set < Imm Unsigned (r1 < imm)
#define u_test_sltiu(void)({  \
    rui r1 =  0x2B5AE399;     \
    rui imm = 0x4B5AE399;     \
    ri c =-1;                 \
    asm volatile(           \
    "sltiu %0, %1, %2\n\t"    \
    : "=r" (c)              \
    : "r"  (r1), "r"  (imm));  \
    if(1 != c) goto test_failed;\
})
// Similar to sltiu, (r1 < r2 instead of imm)
#define u_test_sltu(void)({     \
    rui r1 =  0x4B5AE399;       \
    rui r2 =  0x2B5AE399;       \
    ri  c=-1;                   \
    asm volatile(               \
    "sltu %0, %1, %2\n\t"       \
    : "=r" (c)                  \
    : "r"  (r1), "r"  (r2));    \
    if(1 != c) goto test_failed;\
})

// Using PC builtin to make test #TODO:check PC val
#define u_test_jal(void)({      \
    ri imm=0x1234;              \
    rui c  =0;                  \
    rui pc  = curr_pc;          \
    rui exp = pc + imm<<1 + 1;  \
    asm volatile(               \
    "jal %0, %1 \n\t"           \
    : "=r" (c)                  \
    : "r"  (imm));              \
    if(exp != c) goto test_failed;\
})


int main(void)
{
    ri counter = 0;

    u_test_add();counter++;
    u_test_addi();counter++;
    u_test_sub();counter++;
    u_test_andi();counter++;
    u_test_or();counter++;
    u_test_slli();counter++;
    u_test_srli();counter++;
    u_test_auipc();counter++;
    // u_test_lw();counter++;
    // u_test_sw();counter++;
    // u_test_lui();counter++;
    u_test_xor();counter++;
    // u_test_lbu();counter++;
    u_test_sltiu();counter++;
    u_test_sltu();counter++;
    u_test_jal();counter++;
    
test_failed: return counter;
}

