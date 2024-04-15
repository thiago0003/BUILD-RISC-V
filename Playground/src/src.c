#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define for_x(height) for(int x=0; x<(height); x++ )
#define for_y(width) for(int y=0; y<(width); y++ )
// easier access to the boards (the sizes are predefined?)
#define at(x,y,w,h) ((x)+(w)*(y))
#define MIN(x,y) ( (x) > (y) ? (y) : (x) )
#define TOTAL_SHIPS (5)

// TODO: implementar board com uso mais eficiente, seria com enum ou com struct ? 
// typedef struct test_board {
//     unsigned bits[4];
// }test_board;

// struct board_game{
//     type_b board,
//     aval_ships; 
// }


// Mask to remove UPPER_BITS or LOWER_BITS of size 8 bits
#define SHIPS_ID(input)   (0x0f & (input)) 
#define SHOOTS_T(input)   (0xf0 & (input))

// Mask to preview Ship type(3bits)
#define SHIP_TYPE(input) (0x07 & (input)) 

// Mask to preview data with shoot
#define INSERT_SHOT(input) (0x10 | (input)) 

// Mask to preview include hit
#define INCLUDE_HIT(input) (0x08 | (input)) 


// Just for input coordinates
char toUpper(char c){
    if(c >= 'a' && c <= 'z') return c - 'a' + 'A';
    return c;
}

// TODO: how to make it more efficient ? Create a function with direction param
#define HORIZONTAL  (0)
#define VERTICAL  (1)

// Define size of the ships
typedef enum ships{
    Ocean      = 0,
    Carrier    = 5, 
    Battleship = 4,
    Cruiser    = 3,
    Submarine  = 3,
    Destroyer  = 2  
} ships;


typedef enum ship_id
{
    id_Ocean      = 0x00,
    id_Carrier    = 0x01,
    id_Battleship = 0x02,
    id_Cruiser    = 0x03,
    id_Submarine  = 0x04,
    id_Destroyer  = 0x05 
}ship_id;

// Arrays to define a std to the game
const int ships_size[] = {Ocean, Carrier, Battleship, Cruiser, Submarine, Destroyer};
const int ships_id[] = {id_Ocean, id_Carrier, id_Battleship, id_Cruiser, id_Submarine, id_Destroyer};

// We dont have rand() in our problem, so we have an implementation
int rand_for_dummies(){
    return rand();
}


void display_board(int w, int h,
                   char board[])
{
    char line = 'A';

    printf("   ");for_x(h) printf("%2i ", x);printf("| ");
    for_x(h) printf("%2i ", x);printf("\n   ");
    for_x(2*h) printf("---"); printf("\n");
    for_y(w){

        printf("%c| ", line++);
        for_x(h) printf("%2c ", SHIPS_ID(board[at(x,y, w, h)]) ? 
                        '@' + SHIPS_ID(board[at(x, y, w, h)]): ' ');
        printf("| ");
        
        //  Representacao de historico de Tiros
        for_x(h) printf("%2c ", SHOOTS_T(board[at(x,y, w, h)]) !=0?  'x': ' ');
        printf("\n");
    }
    for_x(2*h) printf("---"); printf("\n\n");

}


// This function returns if, given a coordinate, have a sunk ship
int ship_is_sunk(int w, int h,char board[],int coordX, int coordY )
{    
    const int pos_board = SHIPS_ID(board[at(coordX, coordY, w, h)]);
    const int type = 0x07 & pos_board;
    const int size = ships_size[type];  
    
    //constraint
    if(INCLUDE_HIT(pos_board) != pos_board || type == id_Ocean ) return 0;


    int acc = 1;
    int x;
    for (x = coordX + 1; x  < w && SHIPS_ID(board[at(x, coordY, w, h)]) == pos_board; x++) acc++;
    for (x = coordX - 1; x >= 0 && SHIPS_ID(board[at(x, coordY, w, h)]) == pos_board; x--) acc++;

    printf("size of boat = %i\nRemaining %i\nCode of Boat = %i\n", size, acc, type);
    if (acc >= size) return 1;
    
    // Vertical
    acc = 1;
    int y;
    for (y = coordY + 1; y  < h && SHIPS_ID(board[at(coordX, y, w, h)]) == pos_board; y++) acc++;
    for (y = coordY - 1; y >= 0 && SHIPS_ID(board[at(coordX, y, w, h)]) == pos_board; y--) acc++;

    return acc >= size;
}

void input_coord(int *cd_x, int *cd_y,int w, int h, char board[])
{
    
    bool valid= false;
    char tmp;
    int x,y;
    while(!valid){
        printf("\nInsert Coordinates[xy]: ");
        scanf("%[A-Za-z]%i",&tmp, &x);

        //format to 0-w
        y = toUpper(tmp) - 'A';

        valid = (y <= w) &&  (x <= h) && (y >= 0) && (x >= 0) ;// &&
                //(SHOOTS_T(board[at(y, x, w, h)] == 0));// check if have shoot there
        // clear buffer 
        while (getchar() != '\n');
        if(!valid) printf("Invalid, try Again\n");
    }
    
    *cd_x = x; 
    *cd_y = y;

}
bool hit(char player1[], char player2[], int x, int y, int w, int h)
{
    //Insert pos shot - Log
    player1[at(x,y,w,h)] = INSERT_SHOT(player1[at(x,y,w,h)]);
    

    //insert hit on Ships - On second Board
    if (SHIPS_ID(player2[at(x,y,w,h)]) == id_Ocean) return false;

    player2[at(x,y,w,h)] = INCLUDE_HIT(player2[at(x,y,w,h)]);
    return true;

}

//  Changes the situation of the board and return if theres a new ship sunk
int shoot_player(int w, int h, /* board_size */
                 int x,int y,/*(x,y) coordinates to shoot*/
                 int num_player,
                 char player1[],char player2[])
{
    bool t = false;
    // check if coordinate have a ship
    if(num_player == 0){
        t = hit(player1, player2, x, y, w, h);
        return  ship_is_sunk(w,h ,player2, x, y);
    }
    
    t = hit(player2, player1, x, y, w, h);
    return ship_is_sunk(w, h , player1, x, y);
}


void game(int w, int h, char player1[], char player2[])
{

    //stores status for player
    int num_player = 0;
    int cd_x, cd_y;
    int sunk_ships[2] = {0};

    while(sunk_ships[0] != TOTAL_SHIPS && sunk_ships[1] != TOTAL_SHIPS )
    {
        // Read coordinates
        input_coord(&cd_x, &cd_y, w, h,  player1);
        
        sunk_ships[num_player] += shoot_player(w, h, cd_x, cd_y,(int)num_player, player1, player2);
        // wait_response();
        // refresh_boards();
        //  change player!
        printf(".......First Player.......\n");
        printf("Remaining Ships: %i\n", TOTAL_SHIPS - sunk_ships[1]);
        display_board(w,h,player1);
        
        printf(".......Scond Player.......\n");
        printf("Remaining Ships: %i\n", TOTAL_SHIPS - sunk_ships[0]);
        display_board(w,h,player2);
        
        num_player = (num_player+1)%2;
    }
}

void shuffle_board(int w, int h,
        char board[])
{   
    int ptr_ships = 1;
    while(ptr_ships != TOTAL_SHIPS+1){
        bool filled = false;
        do{
            int pos_y = rand_for_dummies()%w;
            int pos_x = rand_for_dummies()%h;
            int orientation = rand_for_dummies()%2;
            int tmp[5] = {0}; //temporary array to store values in board
            int size = ships_size[ptr_ships]; //size of actual ship
            int id = ships_id[ptr_ships];
            int aval_space = 0;
            
            // if already selected, try again
            if(board[at(pos_x, pos_y, w, h)]!= 0) continue;
        
            // TODO: make it a single function
            switch (orientation)
            {
                case HORIZONTAL:
                {
                    int left = pos_x-1;
                    int right = pos_x;

                    // Check if  positions are available (left and right)
                    while((left > 0)         &&
                        (aval_space < size)  &&
                        (board[at(left, pos_y, w, h)] == 0)) tmp[aval_space++] = left--;
                    while((right < h)        &&
                        (aval_space < size)  &&
                        (board[at(right, pos_y, w, h)] == 0)) tmp[aval_space++] = right++;
                        
                    // Fill board
                    if(aval_space == size){
                        while(aval_space--){
                            board[at(tmp[aval_space], pos_y, w, h)] = ships_id[ptr_ships];
                            // printf("(%i,%i), ",tmp[aval_space], pos_y);
                        }
                        // printf("\n");
                        filled = true;
                    }
                    break;
                }    
                case VERTICAL:
                {
                    int up = pos_y-1;
                    int down = pos_y;

                    // Check if  positions are available (up and down)
                    while((up > 0)           &&
                        (aval_space < size)  &&
                        (board[at(up, pos_y, w, h)] == 0)) tmp[aval_space++] = up--;
                    while((down < h)         &&
                        (aval_space < size)  &&
                        (board[at(down, pos_y, w, h)] == 0)) tmp[aval_space++] = down++;

                    // Fill board
                    if(aval_space == size){
                        while(aval_space--){
                            board[at(pos_x, tmp[aval_space], w, h)] = ships_id[ptr_ships];
                            //printf("(%i,%i), ", pos_y,tmp[aval_space]);
                        }
                        // printf("\n");
                        filled = true;
                    }   
                     break;
                }
            }
        }while(!filled);
        ptr_ships++;
    }
}


int main() 
{
    const int width = 10; 
    const int height = 10;
    char board_p1[100] = {0};
    char board_p2[100] = {0};
    // srand(777);
    // // Shuffle  boards befor game starts
    shuffle_board(width, height, board_p1);
    shuffle_board(width, height, board_p2);
    display_board(width, height, board_p1);
    display_board(width, height, board_p2);
    

    while(1)
    {
        game(width, height, board_p1, board_p2);
    }

    int a,b;
    // while (1)
    // {
    //     input_coord(&a,&b, width, height, board_p1);
    //     printf("Formatted out: %i, %i\n", a, b);
    // }

    return 0;
}




