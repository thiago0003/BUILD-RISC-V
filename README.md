# Build Game Of Life

Como primeira etapa desse projeto foi desenvolvido o jogo Game Of Life de forma tradicional e efetuado a compilação gerando o conjunto de instruções RISC-V para analisarmos. 

[Start Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/game_of_life_start.c) 

[RISC-V Assembly Start Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/game_of_life_start.asm). 

## Start Game Of Life
Nessa primeira etapa, podemos observar no assembly instruções como `MUL` e `MULHU` para a criação da matriz e a instrução `REM` que retorna o resto da divisão inteira. Como discutido com o [Prf. Dr. Ricardo Menotti](https://github.com/menotti), operações de multiplicação podem ocupar uma área muito maior dentro da [FPGA](https://www.intel.com.br/content/www/br/pt/support/programmable/support-resources/fpga-training/getting-started.html) que temos disponível em laboratório.

## Compact Game Of Life
A ideia dessa etapa não é criar uma versão menor ou mais eficiente, queremos criar uma versão que não utilize de operações da extensão de instrução `M`. 

[Compact Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/game_of_life_compact.c) 

[RISC-V Assembly Compact Game Of Life](https://github.com/thiago0003/BUILD-RISC-V/blob/main/game_of_life_compact.asm)

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
| B-Type          |imm\[\12\|10:5\]  | rs2     | rs1     | funct3  | mm\[4:1\|11\]|opcode  |

|Tipo de instrução| 31 - 12                    | 11 - 7 | 6 - 0  |
|:---------------:|:--------------------------:|:------:|:------:|
| U-Type          | imm\[31:12\]               | rd     | opcode |
| J-Type          | imm\[20\|10:1\|11\|19:12\] | rd     | opcode |

|Tipo de instrução| 31 - 20          | 19 - 15 | 14 - 12 | 11 - 7       | 6 - 0  |
|:---------------:|:----------------:|:-------:|:-------:|:------------:|:------:|
| I-Type          |imm\[11:0\]       | rs1     | funct3  | rd           |opcode  |

|Instrução|  Tipo  |
|:-------:|:------:|
| add     | R-Type |
| addi    | I-Type |
| slli    | I-Type |
| sw      | S-Type |
| lw      | S-Type |
| bge     | B-Type |
| beq     | B-Type |
| blt     | B-Type |
| bne     | B-Type |
| auipc   | U-Type |
| jal     | J-Type |
| jalr    | J-Type |

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
