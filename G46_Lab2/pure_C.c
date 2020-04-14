int main() {
		int a[5] = {1,20,3,4,5};		//list data
		int max_val;					//initialize max_val
		max_val = a[0];					//load the first element in the list to max_val
		int i = 0;						//initialize the variables
		int b,c;
		for (i; i<4; i++) {				//for loop scans all elements in the list and compare
			b = a[i+1];					//with max_val, if current element is greater than max_val,
			if (b>max_val) {			//then it replaces max_val
				max_val = b;
			}
		}
		return max_val;					//return the result, which is the greatest number in the list
}
