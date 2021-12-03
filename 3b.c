#include <stdio.h>
#include <stdlib.h>

#define COUNT 12
#define DIAGNOSTICS 1000

typedef struct diagnostic {
    char removed;
    char data[COUNT + 2];
} diagnostic;

diagnostic diags[DIAGNOSTICS];
int removed_count = 0;

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

char get_criteria(int column, int inverse) {
    int zeroes = 0;
    int ones = 0;
    for(int i = 0; i < DIAGNOSTICS; i++) {
        if(!diags[i].removed) (diags[i].data[column] - 48) ? zeroes++ : ones++;
    }

    if(inverse) return (zeroes <= ones) ? '0' : '1';
    return (ones >= zeroes) ? '1' : '0';
}

void remove_all(int column, char criteria) {
    for(int i = 0; i < DIAGNOSTICS; i++) {
        if(diags[i].data[column] != criteria && diags[i].removed == 0 && removed_count != (DIAGNOSTICS - 1)) {
            diags[i].removed = 1;
            removed_count++;
        }
    }
}

void reset() {
    for(int i = 0; i < DIAGNOSTICS; i++) {
        diags[i].removed = 0;
    }
    removed_count = 0;
}

int main() {
    load();

    for(int i = 0; i < COUNT; i++) {
        char criteria = get_criteria(i, 0);
        printf("%c\n", criteria);
        remove_all(i, criteria);
    }

    for(int i = 0; i < DIAGNOSTICS; i++) {
        if(!(diags[i].removed)) printf("%s\n", diags[i].data); 
    }

    reset();

    for(int i = 0; i < COUNT; i++) {
        char criteria = get_criteria(i, 1);
        printf("%c\n", criteria);
        remove_all(i, criteria);
    }

    for(int i = 0; i < DIAGNOSTICS; i++) {
        if(!(diags[i].removed)) printf("%s\n", diags[i].data); 
    }
}