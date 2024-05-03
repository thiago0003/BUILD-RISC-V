#ifndef _BATTLESHIP_H_
#define _BATTLESHIP_H_

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <limits.h> /*INT_MAX*/

#define for_x(height) for(int x=0; x<(height); x++ )
#define for_y(width) for(int y=0; y<(width); y++ )

// Declare max size of the board
#define WIDTH  (10)
#define HEIGHT (10)
#define LENGTH ((WIDTH) * (HEIGHT))

// easier access to the boards (the sizes are predefined?)
#define at(x,y,w,h) ((x)+(w)*(y))

// MIN and MAX definition
#define MIN(x,y) ( (x) > (y) ? (y) : (x) )
#define MAX(x,y) ( (x) > (y) ? (x) : (y) )


// Mask to remove UPPER_BITS or LOWER_BITS of size 8 bits
#define SHIPS_ID(input)   (0x0f & (input)) //LOWER HALF
#define SHOOTS_T(input)   (0xf0 & (input)) //UPPER HALF

// Mask to preview Ship type(3bits)
#define SHIP_TYPE(input) (0x07 & (input)) 

// Mask to preview data with shoot
#define INSERT_SHOT(input) (0x10 | (input)) 

// Mask to preview include hit
#define INCLUDE_HIT(input) (0x08 | (input)) 


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
    id_Carrier    ,//= 0x01,
    id_Battleship ,//= 0x02,
    id_Cruiser    ,//= 0x03,
    id_Submarine  ,//= 0x04,
    id_Destroyer  //= 0x05 
}ship_id;

#define total_ships ((int)(id_Destroyer) - (int)(id_Ocean)+1)
const int ships_size[] = {Ocean, Carrier, Battleship, Cruiser, Submarine, Destroyer};
const int ships_id[] = {id_Ocean, id_Carrier, id_Battleship, id_Cruiser, id_Submarine, id_Destroyer};

const char *ships_names[] = {"id_Ocean", "id_Carrier", "id_Battleship", "id_Cruiser", "id_Submarine", "id_Destroyer"};
// ===================================================================================

// Just for input coordinates
char toUpper(char c){
    if(c >= 'a' && c <= 'z') return c - 'a' + 'A';
    return c;
}
// We dont have rand() in our problem, so we have an implementation
int rand_for_dummies(){
    return rand();
}

// ===================================================================================
typedef struct coordinate{int x, y;}coordinate;

typedef struct board_game{
    char board[WIDTH * HEIGHT];

    // store one position from my ships -> upper left position(x,y)
    coordinate my_ships[total_ships];
    int stamina[total_ships]; 

}board_game;

bool fill_board_with_ships(board_game *board, int id_ship, coordinate *coord_input, bool is_vertical);


//count the total ships remaining in the game
int remaining_ships(board_game *board)
{
    int aux = 0;
    int ans = 0;
    while(aux < total_ships)    
        ans += board->stamina[aux++] != 0 ? 1 : 0; 
    return ans;
}

void blank_board(board_game *board)
{
    memset(board->board, 0, sizeof(char) * LENGTH);

    // Fill the arrays with 0 before start
    memset(board->my_ships, 0, sizeof(coordinate) * total_ships);
    memcpy(board->stamina, ships_size,sizeof(int) * total_ships);
    
}

void display_board_game(board_game *board)
{
    int h = HEIGHT;
    int w = WIDTH;
    char line = 'A';

    printf("   ");for_x(h) printf("%2i ", x);printf("| ");
    for_x(h) printf("%2i ", x);printf("\n   ");
    for_x(2*h) printf("---"); printf("\n");
    for_y(w){

        printf("%c| ", line++);
        // printf("%i| ",  line++ - 'A');
        for_x(h) printf("%2c ", SHIPS_ID(board->board[at(x,y, w, h)]) ? 
                        '@' + SHIPS_ID(board->board[at(x, y, w, h)]): ' ');
       
        printf("| ");
        
        //  Representacao de historico de Tiros
        for_x(h) printf("%2c ", SHOOTS_T(board->board[at(x,y, w, h)]) !=0?  'x': ' ');
        printf("\n");
    }
    for_x(2*h) printf("---"); printf("\n\n");

}

// Shuffle the board and insert the total ships
void shuffle_board(board_game *board) 
{   
    int idx_ship = 1;//the first is ocean 
    const int h = HEIGHT;
    const int w = WIDTH;
    coordinate rand_coordinates;
    // clean board before start
    blank_board(board);
    
    //iterate over the all ships to be inserted 
    while(idx_ship != total_ships){
        bool filled = false;
        do{
            rand_coordinates.y = rand_for_dummies()%w;
            rand_coordinates.x = rand_for_dummies()%h;
            bool orientation = (rand_for_dummies()%2 == 1);

            filled = fill_board_with_ships(board, idx_ship, &rand_coordinates, orientation);
            
            // if(filled)printf(" Filled: %s(%c)  \t-> %i, %c\n", ships_names[idx_ship], 'A'-1+ships_id[idx_ship], rand_coordinates.x,'A' + rand_coordinates.y);
        }while(!filled);
        idx_ship++;
    }// end of shipsiterations
}


bool fill_board_with_ships(board_game *board, int id_ship, coordinate *coord_input, bool is_vertical)
{
    const int w = WIDTH;
    const int h = HEIGHT;
    int tmp_xy[5] = {0};                   //temporary array to store values in board
    int size = ships_size[id_ship];        //size of actual ship
    int id = ships_id[id_ship];            //number id for the actual ship
    int available_places = 0;              //iterate over places available
    const int pos_x = coord_input->x;
    const int pos_y = coord_input->y;
    
    // if already filled, try again
    if((board->board[at(pos_x, pos_y, w, h)] != id_Ocean)) return false; 

    
    int upper = pos_y;
    int lower = pos_y+1;

    int left  = pos_x;
    int right = pos_x+1;

    if(!is_vertical){

        while((available_places < size)  && 
              (upper >= 0)               &&
              (SHIPS_ID(board->board[at(pos_x, upper, w ,h)]) == id_Ocean)) tmp_xy[available_places++] = upper--;

        while((available_places < size) &&
              (lower < h)               &&
              (SHIPS_ID(board->board[at(pos_x, lower, w ,h)]) == id_Ocean)) tmp_xy[available_places++] = lower++;    
    }
    else
    {
        while((available_places < size)  && 
              (left >= 0)                &&
              (SHIPS_ID(board->board[at(left, pos_y, w ,h)]) == id_Ocean)) tmp_xy[available_places++] = left--;

        while((available_places < size) &&
              (right < h)               &&
              (SHIPS_ID(board->board[at(right, pos_y, w ,h)]) == id_Ocean)) tmp_xy[available_places++] = right++;
    }


    if(available_places != size) return false;
        
        

    if(!is_vertical){
        int aux = 0, aux_coord = INT_MAX;
        while(aux < size){
            int vertical_pos = at(tmp_xy[aux], pos_y, w, h);//calc pos.
            board->board[vertical_pos] = ships_id[id_ship];
            aux_coord = MIN(aux_coord, tmp_xy[aux]);
            aux++;
        }
        board->my_ships[id_ship].x = aux_coord;
        board->my_ships[id_ship].y = pos_y;
    
    }else{
    
        int aux = 0, aux_coord = INT_MAX;
        while(aux < size){
            int vertical_pos = at(pos_x, tmp_xy[aux], w, h);//calc pos.
            board->board[vertical_pos] = ships_id[id_ship];
            aux_coord = MIN(aux_coord, tmp_xy[aux]);
            aux++;
        }
        board->my_ships[id_ship].x = pos_x;
        board->my_ships[id_ship].y = aux_coord;
    }
    
    return true;
}
        
    
bool send_missiles(board_game *ally, board_game *enemy, const coordinate coord)
{
    const int w = WIDTH;
    const int h = HEIGHT;
    const int hit_coord = at(coord.x, coord.y, w, h);
    
    // insert in my board shoot thar i made
    ally->board[hit_coord] = INSERT_SHOT(ally->board[hit_coord]);

    // set shoot in the enemy (was i hit ? )
    if(SHIPS_ID(enemy->board[hit_coord]) == id_Ocean) 
        return false;

    //find the ship type attacked
    const ship_id type = enemy->board[hit_coord];


    enemy->board[hit_coord] = INCLUDE_HIT(enemy->board[hit_coord]);
    enemy->stamina[type] = MAX(enemy->stamina[type] - 1 , 0);
    
    return true;
}

void read_coordinates(board_game *board, coordinate *coord) 
{
    
    char tmp;
    int x,y;
    const int h = HEIGHT; 
    const int w = WIDTH;
    bool valid  = false;

    while(!valid){
        printf("\nInsert Coordinates[xy]: ");
        scanf("%[A-Za-z]%i",&tmp, &x);

        //format to 0-w
        y = toUpper(tmp) - 'A';

        valid = (y <= w) &&  (x <= h) && (y >= 0) && (x >= 0) ;
           // &&//(SHOOTS_T(board[at(y, x, w, h)] == 0));// check if we already have shoot there
        // clear buffer 
        printf("Input : %i, %i ", x, y);
        while (getchar() != '\n');
        if(!valid) printf("Invalid, try Again\n");
    }
    
    coord->x = x;
    coord->y = y;
}

#endif //_BATTLESHIP_H_