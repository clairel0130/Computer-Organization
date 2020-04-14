extern int MAX_2(int x, int y);

int main() {
	int b[8] = {2,4,6,9,1,38,37,40};	//input a list of numbers 
	int l = sizeof(b)/sizeof(int);		//compute the size of the input list
	int i = 0;							//initialize the index 
	int c,d,e;							//initialize the int variables
	for (i; i<(l-1);i++) {				//for loop that compares the two neighbouring numbers and store the maximum in e
		c = b[i];
		d = b[i+1];
		e = MAX_2(c,d);
	}
	return e;							//result the maximum number
}
