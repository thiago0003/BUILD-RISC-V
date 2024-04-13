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
#define SHIPS_ID(input)   (0xf  & (input)) 
#define SHOOTS_T(input)   (0xf0 & (input))
#define INCLUDE_HIT(input)(0x08 | (input))

// Just for input coordinates
#define toUpper(c)( if(c >= 'a' && c <= 'z') {c = c - 'a' + 'A';})

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
const int ships_size[] = {Carrier, Battleship, Cruiser, Submarine, Destroyer};
const int ships_id[] = {id_Carrier, id_Battleship, id_Cruiser, id_Submarine, id_Destroyer};

// We dont have rand() in our problem, so we have an implementation
int rand_for_dummies(){
    return rand();
}
// This function returns if, given a coordinate, have a sunk ship
int ship_is_sunk(int w, int h,char board[],int coordX, int coordY )
{    
    int acc = 1;
    int x1, x2, y1, y2;
    x1 = x2 = coordX;
    y1 = y2 = coordY;

    ship_id type = SHIPS_ID(board[at(coordX, coordY, w, h)]);
    int size = ships_size[type];
    
    if(type == id_Ocean) return 0;

    // Check on All directions
        //Horizontal 
    while((x1+1 < w) &&
          (SHIPS_ID(board[at(x1+1, coordY, w, h)] != type)))
        {
            x1++;acc++;
        }
    while((x2-1 > 0) &&
          (SHIPS_ID(board[at(x2-1, coordY, w, h)] != type)))
        {
            x2--;acc++;
        }
    if(acc == size) return 1;
    
        // Vertical
    while((y1+1 < w) &&
          (SHIPS_ID(board[at(coordX, y1+1, w, h)] != type)))
        {
            y1++;acc++;
        }
    while((y2-1 > 0) &&
          (SHIPS_ID(board[at(coordX,y2-1, w, h)] != type)))
        {
            y2--;acc++;
        }

    if(acc == size) return 1;

    return 0;
}


int input_coord(char *cd_x, char *cd_y,int w, int h, char board[])
{
    
    bool valid= false;
    while(!valid){
        printf("Insert Coordinates[xy]: \n");
        scanf("%[A-Za-z]%[0-9]\n",&cd_x, &cd_y);
        // printf("%i %i", toUpper(cd_x), cd_y);

        // valid = toUpper(cd_x) <= 'z';
    }
        
    // cd_y = getchar();

    printf("Input %c, %c", cd_x, cd_y);

}
void hit(int *position)
{
    if (SHIPS_ID(*position) == id_Ocean) return;
    position = INCLUDE_HIT(*position);
}

//  Changes the situation of the board and return if theres a new ship sunk
int shoot_player(int is_1st_player,
                 int w, int h, /* board_size */
                 int cd_x,int cd_y,/*(x,y) coordinates to shoot*/
                 char player1[],char player2[])
{ 
    
    int ans = 0;
    // check if coordinate have a ship
    hit(is_1st_player ? player1[at(cd_x, cd_y, w, h)] : player2[at(cd_x, cd_y, w, h)]);

    return ship_is_sunk(w,h, is_1st_player ? player1 : player2, cd_x, cd_y);
}


void game(int w, int h, char player1[], char player2[])
{

    //stores status for player
    bool is_1st_player = true;
    int cd_x, cd_y;
    int sunk_ships[2] = {0};

    while(sunk_ships[0] != TOTAL_SHIPS && sunk_ships[1] != TOTAL_SHIPS )
    {
        // Read coordinates
        input_coord(cd_x, cd_y, w, h, is_1st_player ? player1 : player2);
        sunk_ships[is_1st_player] += shoot_player(is_1st_player, w, h, cd_x, cd_y, player1, player2);
        // wait_response();
        // refresh_boards();
        //  change player!
        is_1st_player += is_1st_player%2;
    }
}

void shuffle_board(int w, int h,
        char board[])
{   
    int ptr_ships = 0;
    while(ptr_ships != TOTAL_SHIPS){
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
                        '@' + SHIPS_ID(board[at(x,y, w, h)]): ' ');
        printf("| ");

        for_x(h) printf("%2c ", SHOOTS_T(board[at(x,y, w, h)]) ? 
                        '@' + SHOOTS_T(board[at(x,y, w, h)]): ' ');
        printf("\n");
    }
    printf("---------\n");

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
    getchar();
    
    while(1)
    {
        game(width, height, board_p1, board_p2);
    int sunk_ships_p1 = 0;
    }

    return 0;
}




