
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


#define for_x for (int x = 0; x < w; x++)
#define for_y for (int y = 0; y < h; y++)
#define for_xy for_x for_y


void show(void *u, int w, int h)
{
	int (*univ)[w] = u;
	printf("\033[H");
	for_y {
		for_x printf(univ[y][x] ? "\033[07m  \033[m" : "  ");
		printf("\033[E");
	}
	fflush(stdout);
}

unsigned lfsr_gen(int lfsr)
{
    //Mask position
    // unsigned op = (lfsr>>16) ^ (lfsr>>14) ^ (lfsr>>13) ^ (lfsr>>11);
    unsigned op = ((lfsr &(1u << 16))>>16) ^ ((lfsr & (1u << 14))>>14) ^ ((lfsr & (1u << 13))>>13) ^ ((lfsr & (1u << 11))>>11);
    return  op | lfsr<<1;
}

void shuffle(void *u,int w, int h)
{
    int rnd_v = 0x0110;
    int (*p)[w] = u;    
    for_xy
    {  
        rnd_v = lfsr_gen(rnd_v);
        p[y][x] = rnd_v & 1;
    }
}


void evolve(void *u, int w, int h)
{
	unsigned (*univ)[w] = u;
	unsigned new[h][w];

	for_y for_x {
		int n = 0;
		for (int y1 = y - 1; y1 <= y + 1; y1++)
			for (int x1 = x - 1; x1 <= x + 1; x1++)
            {
                if (univ[(y1 + h) % h][(x1 + w) % w])
					n++;
            }
		if (univ[y][x]) n--;
		new[y][x] = (n == 3 || (n == 2 && univ[y][x]));
	}
	for_y for_x univ[y][x] = new[y][x];
}

void game(int w, int h)
{

    unsigned univ[w][h];
    
	int i = 0;
    shuffle(univ,w,h);
    show(univ, w, h);
    sleep(5);
	while (i != 1000) {
		evolve(univ, w, h);
		show(univ, w, h);
		usleep(20000);
		i++;
	}
	printf("------FINISH------\n");
}


int main(int c, char **v)
{
	int w = 30, h = 30;
	game(w, h);
}