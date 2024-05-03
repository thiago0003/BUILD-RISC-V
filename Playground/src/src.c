

#include "Battleship.h"
// Arrays to define a std to the game




// TODO: implementar board com uso mais eficiente, seria com enum ou com struct ? 
// typedef struct test_board {
//     unsigned bits[4];
// }test_board;





void input_coord(int *x_coordinate, int *y_coordinate, board_game *board)
{
    bool valid= false;
    char tmp;
    int x,y;
    int h = HEIGHT, w = WIDTH;
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
    
    *x_coordinate = x; 
    *y_coordinate = y;
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


int total_damage(int x_coordinate, int y_coordinate, board_game *board)
/*
    Input  coordinates (x,y) to check for ship health(if it really has a ship)
    returns: 
    -1: is ocean, so no damage
     0-size(ship): stamina from the boat
*/
{
    int ans = 0;
    
    const int h=HEIGHT, w=WIDTH;
    const int pos_board = SHIPS_ID(board->board[at(x_coordinate, y_coordinate, w, h)]);
    
    // Returns the ship type predefined
    const int type = SHIP_TYPE(pos_board);
    const int size = ships_size[type];

    if(type == id_Ocean) return -1;
    
    //search for the boat (horizontal)
    for (int x = x_coordinate; x  < w 
         && type == SHIP_TYPE(board->board[at(x, y_coordinate, w, h)]) ; x++) 
    {
        int ship_status = SHIPS_ID(board->board[at(x, y_coordinate, w, h)]);
        ans += ship_status == INCLUDE_HIT(ship_status) ? 1: 0;
    }
    for (int x = x_coordinate - 1; x >= 0 
         && type == SHIP_TYPE(board->board[at(x, y_coordinate, w, h)]) ; x--) 
    {
        int ship_status = SHIPS_ID(board->board[at(x, y_coordinate, w, h)]);
        ans += ship_status == INCLUDE_HIT(ship_status) ? 1: 0;
    }
   
    for (int y = y_coordinate + 1; y  < h 
         && type ==  SHIP_TYPE(board->board[at(x_coordinate, y, w, h)]); y++)
    {
        int ship_status = SHIPS_ID(board->board[at(x_coordinate, y, w, h)]);
        ans += ship_status == INCLUDE_HIT(ship_status) ? 1: 0;
    }

    for (int y = y_coordinate - 1; y >= 0 
         && type ==  SHIP_TYPE(board->board[at(x_coordinate, y, w, h)]); y--)
    {
        int ship_status = SHIPS_ID(board->board[at(x_coordinate, y, w, h)]);
        ans += ship_status == INCLUDE_HIT(ship_status) ? 1: 0;
    }

    
    return ans;
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

void DEBUG(board_game *player)
{
    const int h = HEIGHT; 
    const int w = WIDTH;

    printf("Remaining Ships: %i\n", remaining_ships(player));
    printf("Stamina from each Ship:\n");
    for(int i =1; i < total_ships; i++){
        printf("Type [ %c ] = %s \n",'A'-1 + ships_id[i],  ships_names[i]);
        printf("Health      = %i / %i \n", player->stamina[i], ships_size[i]);
        printf("Local[x,y]  = [%c, %i]\n",'A' + player->my_ships[i].y, player->my_ships[i].x );
        
        printf("----------\n");
    }
    display_board_game(player);




}

void game(board_game *player1, board_game *player2)
{

    int num_player = 0;
    const int h = HEIGHT;
    const int w = WIDTH;

    coordinate coord = {-1,-1};


    while(remaining_ships(player1) != 0 && remaining_ships(player2) !=0)
    {
        // TODO: create comm to send value via UART
        if(num_player == 0){
            read_coordinates(player1, &coord);
            bool hit_succesfull = send_missiles(player1, player2, coord);
            
        } else {
            read_coordinates(player2, &coord);
            bool hit_succesfull = send_missiles(player2, player1, coord);
            
        }

        //change round
        num_player += num_player%2;

        printf(".......First Player.......\n");
        DEBUG(player1);

        printf(".......Second Player.......\n");
        DEBUG(player2);


    }

    if(remaining_ships(player1 ) == 0 )
        printf("Victory, Player 2 wins! \n");
    else
        printf("Victory, Player 1 wins! \n");

}


// void game(int w, int h, char player1[], char player2[])
// {

//     //stores status for player
//     int num_player = 0;
//     int cd_x, cd_y;
//     int sunk_ships[2] = {0};
//     const int h = HEIGHT;
//     const int w = WIDTH;

//     while(sunk_ships[0] != TOTAL_SHIPS && sunk_ships[1] != TOTAL_SHIPS )
//     {
//         // Read coordinates
//         input_coord(&cd_x, &cd_y, w, h,  player1);
        
//         sunk_ships[num_player] += shoot_player(w, h, cd_x, cd_y,(int)num_player, player1, player2);
//         // wait_response();
//         // refresh_boards();
//         //  change player!
//         printf(".......First Player.......\n");
//         printf("Remaining Ships: %i\n", TOTAL_SHIPS - sunk_ships[1]);
//         display_board(w,h,player1);
        
//         printf(".......Scond Player.......\n");
//         printf("Remaining Ships: %i\n", TOTAL_SHIPS - sunk_ships[0]);
//         display_board(w,h,player2);
        
//         num_player = (num_player+1)%2;
//     }
// }


int main() 
{
    const int width = 10; 
    const int height = 10;
    srand(777);
    struct board_game player1, player2;

    // // Shuffle  boards before game starts
    shuffle_board(&player1);
    shuffle_board(&player2);

    
    DEBUG(&player1);
    DEBUG(&player2);
    

    game(&player1, &player2);


    int a,b;
    // while (1)
    // {
    //     input_coord(&a,&b, width, height, board_p1);
    //     printf("Formatted out: %i, %i\n", a, b);
    // }

    return 0;
}




