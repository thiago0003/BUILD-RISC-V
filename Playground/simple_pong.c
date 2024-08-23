#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <termio.h>
#include <sys/select.h>
#include <fcntl.h>

#define HEIGHT (30)
#define WIDTH  (30)

#define LAYERS (3)
#define SIZE_PADDLE (10)


#define MIN(a,b) (((a)<(b))?(a):(b))
#define for_x for (int x = 0; x < WIDTH ; x++)
#define for_y for (int y = 0; y < HEIGHT  ; y++)

// change later - dont use multiplication
#define _at(x,y) ((x) + (y)*(WIDTH))




// GLOBAL -- prev declarations
unsigned char visual_board[HEIGHT * WIDTH] = {0};
unsigned char stack_layers[WIDTH * LAYERS] = {0}; 
//for paddle
unsigned char pos_x_paddle =  5;

//for ball
unsigned char pos_x_ball = 8;
unsigned char pos_y_ball = HEIGHT >> 1;

unsigned char prev_x,prev_y;
unsigned char ball_dir = 1;


int read_button();


void _sleep(unsigned int sec)
{
    while(sec--);

}

#ifdef _DEBUG 
// Function to check if a key has been pressed without blocking
int kbhit() {
    struct termios oldt, newt;
    int oldf;
    int ch;
    fd_set readfds;
    struct timeval tv;

    // Set up the file descriptor set
    FD_ZERO(&readfds);
    FD_SET(STDIN_FILENO, &readfds);

    // Set timeout to 0, so select() returns immediately
    tv.tv_sec = 0;
    tv.tv_usec = 0;

    // Get the terminal settings for stdin
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;

    // Disable canonical mode and echo
    newt.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);

    // Set non-blocking mode on stdin
    oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
    fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);

    // Check if data is available
    int result = select(STDIN_FILENO + 1, &readfds, NULL, NULL, &tv);

    // Restore original terminal settings
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    fcntl(STDIN_FILENO, F_SETFL, oldf);

    // Return 1 if key is pressed, 0 otherwise
    return result > 0;
}

// Function to read a single character if available
int read_button() {
    if (kbhit()) {
        char chr = getchar();

        if(chr == 'a') return  1; 
        if(chr == 'd') return -1;
    }
    return 0;  // Return -1 if no key was pressed
}
#else

#define IO_BUTTON_1 (0x1) 
#define IO_BUTTON_0 (0x2)
#define IO_SEND     (0)
#define IO_RECIVED  (1) 

int IOs(int value, int addr, int IO_map);


int IOs(int value, int addr, int IO_map)
{
    register int IO_RECIVED_REG asm("a6");
    IO_RECIVED_REG = 0;

    register int GPIO_addr asm("t0");

    if(IO_map == IO_SEND)
    {
        __asm__ (
            "add %0, zero, zero\n" 
            "addi %0, %0, 1\n" 
            "slli %0, %0, 23\n"        
            "sw %1, (t0)"
            : "+r" (GPIO_addr)
            : "r" (value)
        );
    }
    if(IO_map == IO_RECIVED)
    {
        __asm__ (
            "add %0, zero, zero\n" 
            "addi t0, t0, 1\n" 
            "slli t0, t0, 23\n" 
            "add t0, t0, %1 \n"
            "lw a6, 0(t0)"
            : "+r" (GPIO_addr)
            : "r" (addr)
        );
    }
    return IO_RECIVED_REG;
}


int read_button() {
    
    // if both are pressed - 0, if not +/-1.
    return IOs(0, IO_BUTTON_1, IO_RECIVED) - IOs(0, IO_BUTTON_0, IO_RECIVED);

}

#endif

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

void move_paddle()
{
    // read_button();
    // neither pressed or not, return
    int move = read_button();
    
    if(move == 0) goto update;

    unsigned char res = pos_x_paddle - move;
    
    //bound check
    pos_x_paddle = (0 <= res &&  res + SIZE_PADDLE < WIDTH) ? res : pos_x_paddle;
    // pos_x_ball = 3;

update:
    // update to video.    
    for_x visual_board[_at(x, HEIGHT - 2)] = (x >  pos_x_paddle-1) && 
                                         (x < pos_x_paddle + SIZE_PADDLE+1); 

}


void move_ball()
{




}


void game(){
    move_paddle();
    move_ball(); 
    hit();
    show();
    usleep(100);
}

// void setup_game()
// {
//     for_x for(int l =0;l < LAYERS; l++)
//         stack_layers[_at(x,l)] = 0;
//     while (getchar())
//     {
//     bounce();
     
//     update_v_ball();
//     update_v_layers();
//     update_v_paddle();    
//     show();
//     }
// }


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




void ball()
{

}

int main()
{


    // setup_game();
    while(1) game();
    // while (1)
    // {
    //     int i = read_button();
    //     if(i!= 0) printf("button press %i\n", i);
    //     usleep(1100);
    // }


    return 0;
}