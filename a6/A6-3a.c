#include <stdio.h>


int arr[10]; 
int* head = arr;

void function1(int c, int d){
	head[d] = head[d]+c;
}

int main(int argc, char** argv){
	int a=1;
	int b=2;
	function1(3,4);
	function1(a,b);
	for(int i=0; i<10; i++)
	printf("%d\n",arr[i]);
}


