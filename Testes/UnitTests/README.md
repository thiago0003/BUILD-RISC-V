## Implementação de TestBench - RISCV

Esta pasta tem como objetivo gerar testes unitários feitos por meio da elaboração de [Inlining Assembly](https://gcc.gnu.org/onlinedocs/gcc/extensions-to-the-c-language-family/how-to-use-inline-assembly-language-in-c-code.html) via GCC, onde tomamos como Referencia Oficial o [Green Card RISC-V](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf) para desenvolvimento de tais testes.


## TODO-LIST

|    |Instrução |  Tipo  |
|:--:|:--------:|:------:|
| ☑️ | add      | R-Type  |
| ☑️ | addi     | I-Type  |
| ☑️ | sub      | R-Type  |
| ☑️ | andi     | I-Type  |
| ☑️ | or       | R-Type  |
| ☑️ | slli     | I-Type  |
| ☑️ | srli     | I-Type  |
| ☑️ | auipc    | U-Type  |
| ? | lw       | I-Type  |
| ? | sw       | S-Type  |
| ? | lui      | U-Type  |
| ☑️ | Xor      | R-Type  |
| ? | lbu      | I-Type  |
| ☑️ | sltiu    | I-Type  |
| ☑️ | sltu     | R-Type  |
| ☑️ | jal      | J-Type  |
| - | jalr     | I-Type  |
| - | beq      | B-Type  |
| - | bne      | B-Type  |
| - | blt      | B-Type  |
| - | bge      | B-Type  |
| - | sb       | S-Type  |
| - | bltu     | B-Type  |
| - | bgeu     | B-Type  |
| - | lb       | I-Type  |
| - | lh       | I-Type  |
| - | lhu      | I-Type  |
| - | sh       | S-Type  |
| - | slti     | I-Type  |
| - | xori     | I-Type  |
| - | ori      | I-Type  |
| - | srai     | I-Type  |
| - | sll      | R-Type  |
| - | slt      | R-Type  |
| - | srl      | R-Type  |
| - | sra      | R-Type  |
| - | and      | R-Type  |        
*/