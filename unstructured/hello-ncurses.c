// cc -lncurses %

#include <stdio.h>
#include <ncurses.h>

int main(int argc, char *argv[]) {
    initscr();
    mvprintw(10, 10, "Hello, world!");
    refresh();
    getch();
    endwin();
    return 0;
}
