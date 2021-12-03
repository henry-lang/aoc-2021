#include <stdio.h>
#include <stdlib.h>

#define COUNT 12

int main() {
    FILE *input;
    if((input = fopen("./input/3.txt", "r")) == NULL) {
       printf("Couldn't open input.");
       exit(1);
    }

    char line[COUNT + 2] = {0};
    int values[COUNT][2] = {0};
    while(fgets(line, COUNT + 2, input)) {
        for(int i = 0; i < COUNT; i++) {
            values[i][line[i] - 48]++;
        }
    }

    unsigned long gamma = 0;
    unsigned long epsilon = 0;
    for(int i = 0; i < COUNT; i++) {
        if(values[i][1] > values[i][0]) {
            gamma |= 1UL << (COUNT - i - 1);
        }
    }
    epsilon = ~(gamma) & 0xfff;
    printf("%lu %lu\n", gamma, epsilon);
    printf("%lu\n", gamma * epsilon);

    fclose(input);
}