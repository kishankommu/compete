#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void arrayBuilder(long long int * array,long long int pos, long long int entry);
void displayArray(long long int *array,long long int size);
void sortArray(long long int *number,long long int size);
long long int  findZeroCons(long long int *array,long long int size);
long long int  findConscOne(long long int *array,long long int size);
long long int  findTwoCons(long long int *array,long long int size);
void processArray(long long int *array,long long int size);


int main()
{
	long long int N,i = 1,k = 0,element;
	char c;
	scanf("%lld",&N);
  
	while(i <= N){
		caseBegin:
		scanf("%lld",&k);
		//printf("This is a new set with entries %lld\n",k );

		long long int tmp,tpos = 0;
		long long int* problemCase = (long long int*) malloc(sizeof(long long int)* k);

		while(scanf("%lld%c",&tmp,&c) != EOF){
			if (c == '\n'){
				//printf("%lld\n",tmp );
				arrayBuilder(problemCase,tpos++,tmp);
				i++;
				processArray(problemCase,tpos);
				goto caseBegin;
			}else{
				//printf("--%lld\n",tmp );
				arrayBuilder(problemCase,tpos++,tmp);
			}
		}
		i++;
		processArray(problemCase,tpos);
    }
    return 0;
}



void arrayBuilder(long long int * array,long long int pos, long long int entry){
	array[pos] = entry;
}

void displayArray(long long int *array,long long int size){
	printf("Array:\n");
	long long int tmp = 0;
	for (long long int i = 0; i < size; ++i){
		printf("%lld, ", array[i]);
	}
	printf("\n");
}

void sortArray(long long int *number,long long int size){
	long long int i,j,n,a;
	n = size;

	for (i = 0; i < n; ++i)
    {
        for (j = i + 1; j < n; ++j)
        {
            if (number[i] > number[j])
            {
                a =  number[i];
                number[i] = number[j];
                number[j] = a;
            }
        }
    }
}
long long int findConscOne(long long int *array,long long int size){
	long long int tmp = 0;
	for (long long int i = 0; i < size; ++i){
		if (i > 0 && i < size-1){
			//compare both side
			if (array[i]-array[i-1] == 1 && array[i+1]-array[i] != 1){
				tmp++;
			}
		}else if (i == 0){
			//compare only right side not needed
		}else if (i == size-1){
			//compare only left side
			if (array[i]-array[i-1] == 1){
				tmp++;
			}

		}
	}
	//printf(" O(%lld) ",tmp);
	return tmp;
}
long long int findZeroCons(long long int *array,long long int size){
	long long int tmp = 0;
	for (long long int i = 0; i < size; ++i){
		if (i > 0 && i < size-1){
			//compare both side
			if (array[i]-array[i-1] != 1 && array[i+1]-array[i] != 1){
				tmp++;
			}
		}else if (i == 0){
			//compare only right side not needed
		}else if (i == size-1){
			//compare only left side
			if (array[i]-array[i-1] != 1){
				tmp++;
			}

		}
	}
	//printf("\n Z(%lld)",tmp);
	return tmp;
}
long long int findTwoCons(long long int *array,long long int size){
	long long int tmp = 0;
	for (long long int i = 0; i < size; ++i){
		if (i > 0 && i < size-1){
			//compare both side
			if (array[i]-array[i-1] == 1 && array[i+1]-array[i] == 1){
				tmp++;
			}
		}else if (i == 0){
			//compare only right side not needed
		}else if (i == size-1){
			//compare only left side not needed
		}
	}
	//printf(" T(%lld)\n",tmp);
	return tmp;
}

void processArray(long long int *array,long long int size){
	long long int score = size;

	sortArray(array,size);
	//displayArray(array,size);

	score = score - findConscOne(array,size)/2;
	score = score - findTwoCons(array,size);

	printf("%lld\n",score );
}
