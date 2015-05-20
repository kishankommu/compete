#include <stdio.h>
#include <stdlib.h>

long long int ab(long long int x);

int main()
{
	long long int N,i = 1,j = 1;
	scanf("%lld",&N);

	long long int *Dom,*Brain;
	long long int deltaD = -99999999, deltaB= -99999999;


	Dom = (long long int *)malloc(sizeof (long long int )* N);
	Brain = (long long int *)malloc(sizeof (long long int) *N);


	long long int tmp;
	while(scanf("%lld",&tmp) != EOF){
		if (i <= N){
			Dom[i - 1] = tmp;
			//printf("%lld %lld\n",i,Dom[i - 1] );
			i++;
		}else{
			Brain[j - 1] = tmp;
			//printf("-%lld\n",Brain[j - 1] );
			j++;
		}
	}
	for (long long int iterate = 1; iterate < N; ++iterate){
		if (ab(Dom[iterate - 1] - Dom[iterate]) > deltaD){
			 deltaD = ab(Dom[iterate - 1] - Dom[iterate]);
		}
		if (ab(Brain[iterate - 1] - Brain[iterate]) > deltaB){
			deltaB = ab(Brain[iterate - 1] - Brain[iterate]);
		}
		
	}

	if (deltaB > deltaD){
		printf("Brian\n%lld",deltaB);
	}else if(deltaB < deltaD){
		printf("Dom\n%lld",deltaD);
	}else{
		printf("Tie\n%lld",deltaD);
	}
    return 0;
}

long long int ab(long long int x){
	if (x >= 0){
		return x;
	}else{
		return x * -1;
	}
}