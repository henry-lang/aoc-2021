#include <stdio.h>
#include <stdlib.h>

#define COUNT 13

int main() {
    FILE *input;
    if((input = fopen("./input/3.txt", "r")) == NULL) {
       printf("Couldn't open input.");
       exit(1);
    }

    char line[COUNT];
    fscanf(input, "%s\n", line);


    fclose(input);
}