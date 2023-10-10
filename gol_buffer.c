#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define h 480
#define w 640

#define for_x for (int x = 0; x < w; x++)
#define for_y for (int y = 0; y < h; y++)

unsigned char univ[h][w];
unsigned char b1[w], b2[w], prev[w], head[w];
unsigned char n;

void show()
{
	printf("\033[H");
	for_y {
		for_x printf(univ[y][x] ? "\033[07m  \033[m" : "  ");
		printf("\033[E");
	}
	fflush(stdout);
}

void evolve()
{
	// prologo
	for_x {
		head[x] = univ[0][x]; 
		prev[x] = univ[h-1][x]; 
	}
	// kernel
	for (int y = 0; y < h-1; y++) { 
		for_x {
			n = prev     [x ? x-1 : w-1] + prev     [x] + prev     [x==w-1 ? 0 : x+1] +
			    univ[y  ][x ? x-1 : w-1] +                univ[y  ][x==w-1 ? 0 : x+1] +
			    univ[y+1][x ? x-1 : w-1] + univ[y+1][x] + univ[y+1][x==w-1 ? 0 : x+1]; 
			b1[x] = ((n | univ[y][x]) == 3);
		}
		for_x {
			prev[x] = univ[y][x];
			if (y > 0) 
				univ[y-1][x] = b2[x];
			b2[x] = b1[x];
		}
	}
	// epilogo
	for_x {
		n = prev     [x ? x-1 : w-1] + prev   [x] + prev     [x==w-1 ? 0 : x+1] +
		    univ[h-1][x ? x-1 : w-1] +              univ[h-1][x==w-1 ? 0 : x+1] +
		    head     [x ? x-1 : w-1] + head   [x] + head     [x==w-1 ? 0 : x+1]; 
		b2[x] = ((n | univ[h-1][x]) == 3);
	}
	for_x {
		univ[h-2][x] = b1[x];
		univ[h-1][x] = b2[x];
	}
	
}

void main(int c, char **v)
{
	for_x for_y univ[y][x] = rand() < RAND_MAX / 10 ? 1 : 0;
	while (1) {
		show();
		evolve();
		usleep(2000);
	}
}