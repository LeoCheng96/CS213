int p1;
int p2;
int p3;
int returnVal;

int foo(int i, int j, int k) {
	int tmp;
	switch(i) {
		case 10:
			tmp = j+k;
			break;
		case 12:
			tmp = j-k;
			break;
		case 14:
			if (j>k) {
				tmp = 1;
			} else {
				tmp = 0;
			}
			break;
		case 16:
			if (j<k) {
				tmp = 1;
			} else {
				tmp = 0;
			}
			break;
		case 18:
			if (j==k) {
				tmp = 1;
			} else {
				tmp = 0;
			}
			break;
		default:
			tmp = 0;
			break;
		}
		return tmp;
	}

int main(void) {
	returnVal = foo(p1,p2,p3);
}
