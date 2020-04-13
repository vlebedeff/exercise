typedef struct {
    unsigned capacity;
    unsigned *head;
    unsigned *tail;
}

int main(int argc, char *argv[])
{
    
    return 0;
}

head: []
tail: []

# append 1

head: []
tail: [1]

# append 2

head: []
tail: [2, 1]

# append 3

head: []
tail: [3, 2, 1]

# append 4

head: [1, 2, 3]
tail: [4]

data: [x, x, x, 1, 2, 3, 4, 5, x, x, x]
                ^           ^
                head        tail
      |_hd_-_dt_|
      |___________capacity____________|

empty: [x, x, x, x]
        ^
        head
        ^
        tail
        ^
        sentinel

singleton: [42, x, x, x, x]
            ^   ^
            hd  sentinel
            ^
            tail

shift: [42, x, x, x, x]
        ^
        hd
        ^
        tail
        ^
        sentinel
