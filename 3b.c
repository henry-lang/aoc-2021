#include <stdio.h>
#include <stdlib.h>

#define COUNT 12
#define DIAGNOSTICS 1000

typedef struct diagnostic {
    char removed; 
    char data[COUNT + 2];
} diagnostic;

diagnostic diags[DIAGNOSTICS] = {0};

void load() {
    FILE *input;
    if((input = fopen("./input/3.txt", "r")) == NULL) {
       printf("Couldn't open input.");
       exit(1);
    }

    int cur_line = 0;
    while(fgets(diags[cur_line].data, COUNT + 2, input)) {
        diags[cur_line].removed = 0;
        diags[cur_line].data[COUNT] = '\0';
        cur_line++;
    }

    fclose(input);
}

int get_criteria(int inverse) {
    int zeroes = 0;
    int ones = 0;
    for(int j = 0; j < DIAGNOSTICS; j++) {
        (diags[j].data[i] - 48) ? zeroes++ : ones++;
    }

    if(inverse) return (zeroes >= ones) ? 0 : 1;
    return (ones >= zeroes) ? 1 : 0;
}

void reset() {
    for(int i = 0; i < DIAGNOSTICS; i++) {
        diags[i].removed = 0;
    }
}

int main() {
    load();

    reset();

    for(int i = 0; i < COUNT; i++) {
        
    }

    
}