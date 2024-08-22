#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


#define HEIGHT (30)
#define WIDTH  (30)

#define LAYERS (3)
#define SIZE_PADDLE (10)


#define MIN(a,b) (((a)<(b))?(a):(b))
#define for_x for (int x = 0; x < HEIGHT ; x++)
#define for_y for (int y = 0; y < WIDTH  ; y++)

// change later - dont use multiplication
#define _at(x,y) ((x) + (y)*(WIDTH))




// GLOBAL -- prev declarations
unsigned char visual_board[HEIGHT * WIDTH] = {0};
unsigned char stack_layers[WIDTH * LAYERS] = {0}; 
//for paddle
unsigned char pos_x_paddle =  5;
unsigned char pos_y_paddle =  5 + SIZE_PADDLE;


//for ball
unsigned char pos_x_ball = 8;
unsigned char pos_y_ball = HEIGHT >> 1;

unsigned char prev_x,prev_y;
unsigned char ball_dir = 1;

// necessary ?
unsigned char l_button = 0;
unsigned char r_button = 0;

void move_paddle();
void update_v_ball();
void update_v_paddle();
void update_v_layers();
void bounce();

void _sleep(unsigned int sec)
{
    // const int  cte = 25e3 * 2;
    // int itr = sec * cte;

    // while(itr--);
    usleep(1000);
}


// IO input -- change later.
void read_button()
{  
    unsigned char t = getchar();
    switch (t)
    {
    case 'a': {
        l_button = 1;
        break;
    }
    case 'd': {
        r_button = 1;
        break;
    }
    default: l_button = r_button = 0;
    }
}

//only for debug
void show()
{
	printf("\033[H");
	for_y {
		for_x printf(visual_board[_at(x,y)] ? "\033[07m  \033[m" : "  ");
		printf("\033[E");
	}
	fflush(stdout);
}

// // Alternative random - we must create a new one ?
// unsigned char alt_rand(){
//     return rand();
// }




void game()
{
}

void setup_game()
{
    for_x for(int l =0;l < LAYERS; l++)
        stack_layers[_at(x,l)] = 0;
    while (getchar())
    {
    bounce();
     
    update_v_ball();
    update_v_layers();
    update_v_paddle();    
    show();
    }
}

void update_v_layers(){
    for(int l = 0; l < LAYERS;l++)
    {
        for_x {
            visual_board[_at(x,l)] = stack_layers[_at(x,l)];
        }
    }
}

void hit()
{
    if(pos_y_ball >= LAYERS) return;

    if(stack_layers[_at(pos_x_ball, pos_y_ball)] == 1) 
        stack_layers[_at(pos_x_ball, pos_y_ball)] == 0;

}


// ball_dir -> direction of the ball (0=right, 1=left, 2=down, 3=up)
// pos_x_ball, pos_y_ball -> current position of the ball
void bounce()
{
    // Move the ball based on its direction
    switch (ball_dir)
    {
    case 0: // Right
        pos_x_ball += (pos_x_ball < WIDTH - 1 ? 1 : 0);
        break;
    case 1: // Up-right
        pos_x_ball += (pos_x_ball < WIDTH - 1 ? 1 : 0);
        pos_y_ball -= (pos_y_ball > 0 ? 1 : 0);
        break;
    case 2: // Up
        pos_y_ball -= (pos_y_ball > 0 ? 1 : 0);
        break;
    case 3: // Up-left
        pos_x_ball -= (pos_x_ball > 0 ? 1 : 0);
        pos_y_ball -= (pos_y_ball > 0 ? 1 : 0);
        break;
    case 4: // Left
        pos_x_ball -= (pos_x_ball > 0 ? 1 : 0);
        break;
    case 5: // Down-left
        pos_x_ball -= (pos_x_ball > 0 ? 1 : 0);
        pos_y_ball += (pos_y_ball < HEIGHT - 1 ? 1 : 0);
        break;
    case 6: // Down
        pos_y_ball += (pos_y_ball < HEIGHT - 1 ? 1 : 0);
        break;
    case 7: // Down-right
        pos_x_ball += (pos_x_ball < WIDTH - 1 ? 1 : 0);
        pos_y_ball += (pos_y_ball < HEIGHT - 1 ? 1 : 0);
        break;
    }

    // Check for collisions and bounce logic
    if (pos_x_ball == 0) // Left wall (with paddle check)
    {
        // if (pos_y_ball >= paddle_y && pos_y_ball < paddle_y + paddle_height)
        {
            // Ball hits the paddle, bounce back to the right
            switch (ball_dir)
            {
            case 3: ball_dir = 1; break; // Up-left -> Up-right
            case 4: ball_dir = 0; break; // Left -> Right
            case 5: ball_dir = 7; break; // Down-left -> Down-right
            }
        }
        // else
        {
            // Ball missed the paddle (Game Over or Reset Logic)
            // Add game over or reset logic here if needed
        }
    }

    if (pos_x_ball == WIDTH - 1) // Right wall
    {
        switch (ball_dir)
        {
        case 0: ball_dir = 4; break; // Right -> Left
        case 1: ball_dir = 3; break; // Up-right -> Up-left
        case 7: ball_dir = 5; break; // Down-right -> Down-left
        }
    }

    if (pos_y_ball == 0) // Top wall
    {
        switch (ball_dir)
        {
        case 1: ball_dir = 7; break; // Up-right -> Down-right
        case 2: ball_dir = 6; break; // Up -> Down
        case 3: ball_dir = 5; break; // Up-left -> Down-left
        }
    }

    if (pos_y_ball == HEIGHT - 1) // Bottom wall
    {
        switch (ball_dir)
        {
        case 5: ball_dir = 3; break; // Down-left -> Up-left
        case 6: ball_dir = 2; break; // Down -> Up
        case 7: ball_dir = 1; break; // Down-right -> Up-right
        }
    }
}

void update_v_ball()
{
    // //fix it
    // print the ball
    visual_board[_at(pos_x_ball, pos_y_ball)] = 1;

}

void update_v_paddle()
{
    for_x
        visual_board[_at(x, HEIGHT-2)] = (x >  pos_x_paddle-1) && 
                                         (x <= pos_x_paddle + SIZE_PADDLE+1);

}

void move_paddle()
{
    // read_button();
    // neither pressed or not, return
    if(r_button == l_button) goto update;
    

    //bound check
    if(l_button && pos_x_paddle >= 0)
        pos_x_paddle--;

    //bound check
    if(r_button && (pos_x_paddle + SIZE_PADDLE < WIDTH))
        pos_x_paddle++;

update:
    //update position
    update_v_paddle(); 
}


void ball()
{

}

int main()
{

    setup_game();
    show();
    getchar();
    game();




    return 0;
}