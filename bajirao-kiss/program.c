#include <stdio.h>
#include <string.h>


int main(){
	int N = 0,i,flag;
	char word[101];
	scanf("%d",&N);
	while(N--){
		scanf("%s",(char *)&word);
		i = strlen(word);
		flag = 0;
		while(i > 0){
			if (word[i] == word[i-1]){
				printf("SLAP\n");
				flag = 1;
				break;
			}
			i--;
		}
		if (!flag)
			printf("KISS\n");
	}
    return 0;
}

