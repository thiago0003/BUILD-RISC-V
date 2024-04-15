# Desenvolvimento de Jogo em LL(Low Level) - Battleship

Nesta pasta, teremos todo o desenvolvimento do jogo Battleship em arquitetura RISCV, com  o uso da FPGA TANG Nano 20K.

Requisitos: 

|OK?|Descricao|
|-|-|
||Leitura de Mapa ASCII (mais simples,p/ menor consumo)|
||Mapeamento da escr|
||Implementacao do Jogo(software e SEM multplicacao e DIV)|
||Entrada Aleatoria das posicoes de navio(s/sobreposicao)|



## INFO - ARQUITETURA  || DESENVOLVIMENTO
128 X 64 -- Tam. do visor. 

Display 01 - Navios Aliados

Display 02 - Zona de Tiro  - Navios Inimigos

## COMO ARMAZENAMOS OS DADOS ? 
Para esta implementacao, estamos tomando como base char (8 bits) para armazenamento dos dados dos dois mapas. Para isso, dividimos em duas secoes para facilitar o seccionamento de dados:

```
Representacao de um bloco char:
|  8-5 bits  |  4-0 bits  |
    |             +--> Barco(e se foi atingido)
    +--> Mapa de tiros do Jogador

Do qual: 
| 4 | 3 - 0 | (bits)
  |    +-> tipo do barco
  +--> Se foi atigindo

Ex: 1_101: Barco do Tipo Destroyer Atigindo nesta posição
```

## DESAFIOS
Size == 1024  bytes de variavel.

## Proximos Passos
Caso Desejemos utilizar um menor consumo de memória(ex 8b -> 4b), será necessario reduzir o total de navios do jogo, dado que o total atual de barcos são 5.



## Referencias

