#include <stdio.h>

int x[8]={1,2,3,-1,-2,0,184,340057058};
int y[8];

int fn(int x){
	int c=0; 
	while (x!=0){
		if((x & 0x80000000)!=0){
			c++;
		}
		x = x << 1;
	}
	return c;
}

int main (int argc, char** argv) {

	for(int i=8; i>=0; i--){
		y[i]=fn(x[i]);
	}
	
	for(int i=0; i<8; i++)
	printf("%d\n",x[i]);
	for(int i=0; i<8; i++)
	printf("%d\n",y[i]);
	
}
