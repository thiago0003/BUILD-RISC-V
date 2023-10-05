
#include <stdlib.h>
#include <stdio.h>

int main(void) 
{
    int n = 1, fib = 0, aux = 0;    
    
    while(1)//Só vai mostrar até 1000
    {                 
        fib = fib + aux;                 
        aux = n;

        printf("%d\n:", fib);        
    }
  return 0;
}

