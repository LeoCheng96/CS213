#include <stdio.h>
#include <stdlib.h> 


struct Foo {         //d0
    struct dd* d1;
    struct dd* d2;
};

//struct Foo* s;

struct dd {          //d1 and d2
    int x;
    int y;
};
int main() {



    struct Foo* s = (struct Foo*)malloc(sizeof(struct Foo));
    s->d1 = (struct dd*)malloc(sizeof(struct dd));
    s->d2 = (struct dd*)malloc(sizeof(struct dd));
    
    s->d1->x = 1;
    s->d1->y = 2;
    
    s->d2->x = 3;
    s->d2->y = 4;
    
    s->d2->x = s->d1->y;
    s->d1->x = s->d2->y;
    
    printf("%d\n", s->d1->x);
    printf("%d\n", s->d1->y);
    printf("%d\n", s->d2->x);
    printf("%d\n", s->d2->y);
    return 0;
} 




