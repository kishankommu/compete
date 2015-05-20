#include <stdio.h>

int main(){
	char tmp;
	int total = 0;
	while(scanf("%c",&tmp) != EOF){
		switch (tmp){
			case '1':
			total = total + 2;
			break;

			case '7':
			total = total + 3;
			break;

			case '4':
			total = total + 4;
			break;

			case '2':
			case '3':
			case '5':
			total = total + 5;
			break;

			case '0':
			case '6':
			case '9':
			total = total + 6;
			break;

			case '8':
			total = total + 7;
			break;

		}
	}	
    printf("%d",total);
    return 0;
}

