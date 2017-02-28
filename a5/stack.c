#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct Element {
  char   name[200];
  struct Element *next;
};

struct Element *top = 0;
int pt[100];
int acc=0;


void push (char* aName) {
  struct Element* e = malloc (sizeof (*e));    // Not the bug: sizeof (*e) == sizeof(struct Element)
  strncpy (e->name, aName, sizeof (e->name));  // Not the bug: sizeof (e->name) == 200
  e->next  = top;
  top = e;
}

char* pop() {
  struct Element* e = top;
  struct Element* ret = malloc (sizeof(*ret));
  strncpy(ret->name, top->name, sizeof(top->name));
  char* j = ret->name;
  top = top->next;
  e->next = NULL;
  pt[acc]=ret;
  acc++;
  free (e);
  
  return j;
  
}
int i;
void del() {
   for(i=0; i<acc; i++){
   free(pt[i]);
   }
}


int main (int argc, char** argv) {
  push ("A");
  push ("B");
  char* w = pop();
  push ("C");
  push ("D");
  char* x = pop();
  char* y = pop();
  char* z = pop();
  printf ("%s %s %s %s\n", w, x, y, z);
  del();
}
