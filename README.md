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