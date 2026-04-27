#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int find_substring(char *main_str, char *substr, int *starting_index);

int main(){
	char main_str[30];
	char substr[10];
	int starting_index;

	printf("Please enter a string to search through upi to 30 characters: ");
	scanf("%s", main_str);

	printf("Please enter a substring to search for up to 10 characters: ");
	scanf("%s", substr);
	
	find_substring(main_str, substr, &starting_index);

	if (starting_index != -1)
	{ printf("The substring was found starting at index %d.", starting_index); }
	else
	{ printf("The substring was not found in the main string."); }

	return 0;
}
