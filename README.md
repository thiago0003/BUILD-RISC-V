# Build Game Of Life

Como primeira etapa desse projeto foi desenvolvido o jogo Game Of Life de forma tradicional e efetuado a compilação gerando o conjunto de instruções RISC-V para analisarmos. 
Para a compilação para a CPU RISC-V foi utilizado o site [Compiler Explorer](https://godbolt.org/).


[Start Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/Game_of_life/game_of_life_start.c) 

[RISC-V Assembly Start Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/Game_of_life/game_of_life_start.asm). 

## Start Game Of Life
Nessa primeira etapa, podemos observar no assembly instruções como `MUL` e `MULHU` para a criação da matriz e a instrução `REM` que retorna o resto da divisão inteira. Como discutido com o [Prf. Dr. Ricardo Menotti](https://github.com/menotti), operações de multiplicação podem ocupar uma área muito maior dentro da [FPGA](https://www.intel.com.br/content/www/br/pt/support/programmable/support-resources/fpga-training/getting-started.html) que temos disponível em laboratório.

## Compact Game Of Life
A ideia dessa etapa não é criar uma versão menor ou mais eficiente, queremos criar uma versão que não utilize de operações da extensão de instrução `M`. 

[Compact Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/Game_of_life/game_of_life_compact.c) 

[RISC-V Assembly Compact Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/Game_of_life/game_of_life_compact.asm)

Pontos de mudanças:
* Vetorização das matrizes: Ao invés de utilizarmos matrizes para realizar as operações, toda a estrutura foi trocada para um único vetor.
* Retirada da função `%` (Resto Da Divisão Inteira): Foi substituído a operação por operadores condicionais.
* Foi inserido variáveis de acumulação para que não hovesse necessidade de aplicar multiplicação.

As informações sobre instruções do processador podem ser acessadas em [RISC-V Specification](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf)

## Instruções Contidas No Processador
Nessa sessão será detalhado um pouco das intruções que deverão estar contidas no processador a partir da análise feita no assembly.

|Tipo de instrução| 31 - 25          | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7       | 6 - 0  |
|:---------------:|:----------------:|:-------:|:-------:|:-------:|:------------:|:------:|
| R-Type          |funct7            | rs2     | rs1     | funct3  | rd           |opcode  |
| S-Type          |imm\[11:5\]       | rs2     | rs1     | funct3  | mm\[4:0\]    |opcode  |
| B-Type          |imm\[12\|10:5\]  | rs2     | rs1     | funct3  | mm\[4:1\|11\]|opcode  |

|Tipo de instrução| 31 - 12                    | 11 - 7 | 6 - 0  |
|:---------------:|:--------------------------:|:------:|:------:|
| U-Type          | imm\[31:12\]               | rd     | opcode |
| J-Type          | imm\[20\|10:1\|11\|19:12\] | rd     | opcode |

|Tipo de instrução| 31 - 20          | 19 - 15 | 14 - 12 | 11 - 7       | 6 - 0  |
|:---------------:|:----------------:|:-------:|:-------:|:------------:|:------:|
| I-Type          |imm\[11:0\]       | rs1     | funct3  | rd           |opcode  |

|Instrução|  Tipo  | Instruction Set                                                |
|:-------:|:------:|:---------------------------------------------------------------|
| add     | R-Type | `0000000 \| rs2 \| rs1 \| 000 \| rd \| 0110011`                |
| addi    | I-Type | `imm[11:0] \| rs1 \| 000 \| rd  \| 0010011`                    |
| slli    | I-Type | `0000000 \| shamt \| rs1 \| 001 \| rd \| 0010011`              |
| jalr    | I-Type | `imm[11:0] \| rs1 \| 000 \| rd \| 1100111`                     |
| sw      | S-Type | `imm[11:5] \| rs2 \| rs1 \| 010 \| imm[4:0] \| 0100011`        |
| lw      | S-Type | `imm[11:0] \| rs1 \| 010 \| rd \| 0000011`                     |
| bge     | B-Type | `imm[12\|10:5] \| rs2 \| rs1 \| 101 \| imm[4:1\|11] \| 1100011`|
| beq     | B-Type | `imm[12\|10:5] \| rs2 \| rs1 \| 000 \| imm[4:1\|11] \| 1100011`|
| blt     | B-Type | `imm[12\|10:5] \| rs2 \| rs1 \| 100 \| imm[4:1\|11] \| 1100011`|
| bne     | B-Type | `imm[12\|10:5] \| rs2 \| rs1 \| 001 \| imm[4:1\|11] \| 1100011`|
| auipc   | U-Type | `imm[31:12] \| rd \| 0010111`                                  |
| jal     | J-Type | `imm[20\|10:1\|11\|19:12] \| rd \| 1101111`                    |

### Pseudo instruções
* mov: Copy register, para essa intrução utilizamos a instrução `addi rd, rs, 0`
* ble: Branch if <=, para essa intrução utilizamos a instrução `bge rt, rs, offset`
* j: Jump, para essa intrução utilizamos a instrução `jal x0, offset`
* jr: Jump register, para essa instrução utilizamos a instrução `jalr x0, rs, 0`
* call: Call for-away subrotine, para essa instrução utilizamos o conjunto de instruções `auipc x6, offset[31:12]` e `jalr x1, x6, offset[11:0]`
* li ?
* nop: Stall para saber se o salto será tomado, como RISC-V é incipiente devem incluir essa instrução por precaução. Para essa instrução utilizamos a instrução `addi x0, x0, 0`


## Coisas a investigar
* Foi gerado os arquivos game_of_life_start_report.txt e game_of_life_compact_report.txt, a ideia é analizar os tempos de execução de ambos os programas em x86 e posteriormente (quem sabe) em RISC-V para verificar se há uma melhor otimização no código que não possui as instruções de multiplicação e divisão. Alguma das hipóteses é que com a linearização da matriz obtemos um acesso direto a memória, o que não ocorre na matriz, onde é passado o endereço de um vetor para poder acessar o dado em determinada posição.
* Outra ideia a se investigar seria a diferença entre uma operação de multiplicação utilizando instrução de processador e uma operação de multiplicação utilizando iterações.
* O que aconteceria caso o valor de soma do PC fosse fora do range especificado de 32 bits?


# Build RISC-V
