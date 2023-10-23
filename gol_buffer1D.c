#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define h 30
#define w 30

#define for_x for (int x = 0; x < w; x++)
#define for_y for (int y = 0; y < h; y++)
// #define _idx(x,y) ((w)*(x) +(y)) // using mult... :(
// #define _idx(x,y) ((((x) <<6) + ((x)<<8)) + (y)) // for 640
#define _idx(x,y) ((((x) <<5) - ((x)<<1)) + (y)) // for 30

int univ[h*w];
int b1[w], b2[w], prev[w], head[w];
int n;

void show()
{
	printf("\033[H");
	for_y {
		for_x printf(univ[_idx(y,x)] ? "\033[07m  \033[m" : "  ");
		printf("\033[E");
	}
	fflush(stdout);
}


void evolve()
{
	// prologo
	for_x {
		head[x] = univ[_idx(0, x)]; 
		prev[x] = univ[_idx(h-1, x)]; 
	}
	// kernel
	for (int y = 0; y < h-1; y++) { 
		for_x {
			n = prev          [x ? x-1 : w-1 ] + prev     [x]      + prev          [x==w-1 ? 0 : x+1 ] +
			    univ[_idx(y  , x ? x-1 : w-1)] +                     univ[_idx(y  , x==w-1 ? 0 : x+1)] +
			    univ[_idx(y+1, x ? x-1 : w-1)] + univ[_idx(y+1,x)] + univ[_idx(y+1, x==w-1 ? 0 : x+1)]; 
			b1[x] = ((n | univ[_idx(y,x)]) == 3);
		}
		for_x {
			prev[x] = univ[_idx(y,x)];
			if (y > 0) 
				univ[_idx(y-1, x)] = b2[x];
			b2[x] = b1[x];
		}
	}
	// epilogo
	for_x {
		n = prev     [x ? x-1 : w-1] + prev   [x] + prev     [x==w-1 ? 0 : x+1] +
		    univ[_idx(h-1, x ? x-1 : w-1)] +              univ[_idx(h-1, x==w-1 ? 0 : x+1)] +
		    head     [x ? x-1 : w-1] + head   [x] + head     [x==w-1 ? 0 : x+1]; 
		b2[x] = ((n | univ[_idx(h-1, x)]) == 3);
	}
	for_x {
		univ[_idx(h-2, x)] = b1[x];
		univ[_idx(h-1, x)] = b2[x];
	}
	
}

void main(int c, char **v)
{
    register int lfsr = 0x0110;
	for_x for_y 
    {
        lfsr = (((lfsr &(1u << 16))>>16) ^ ((lfsr & (1u << 14))>>14) ^ ((lfsr & (1u << 13))>>13) ^ ((lfsr & (1u << 11))>>11)) | lfsr<<1;
		univ[_idx(y,x)] = lfsr & 1;
    }

	show();
	usleep(100);

	while (1) {
		show();
		evolve();
		usleep(2000);
	}
}