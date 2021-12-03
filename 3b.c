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
        if(!diags[i].removed) diags[i].data[column] - 48 ? zeroes++ : ones++;
    }
    printf("zeroes: %d\n", zeroes);
    printf("ones: %d\n", ones);
    if(inverse) {
        if(ones == zeroes) {
            return '0';
        }
        if(ones > zeroes) {
            return '1';
        } else return '0';
    } else {
        if(ones == zeroes) {
            return '1';
        }
        if(ones > zeroes) {
            return '0';
        } else return '1';
    }
}

void remove_all(int column, char criteria) {
    printf("%c\n", criteria);
    for(int i = 0; i < DIAGNOSTICS; i++) {
        printf("%d %s\n", diags[i].removed, diags[i].data);
        if(diags[i].removed) continue;
        if(removed_count == DIAGNOSTICS - 1) continue;
        if(diags[i].data[column] != criteria) {
            diags[i].removed = 1;
            removed_count++;
        }
    }
    printf("----------------------------\n");
}

void reset() {
    for(int i = 0; i < DIAGNOSTICS; i++) {
        diags[i].removed = 0;
    }
    removed_count = 0;
}

unsigned long find_stat(int inverse) {
    for(int i = 0; i < COUNT; i++) {
        char criteria = get_criteria(i, inverse);
        remove_all(i, criteria);
    }

    diagnostic *remaining;
    for(int i = 0; i < DIAGNOSTICS; i++) {
        if(!diags[i].removed) {
            printf("%s\n", "remaining found!");
            remaining = &diags[i];
            printf("%s\n", remaining->data);
        } 
    }
    return strtoul(remaining->data, NULL, 2);
}

int main() {
    load();
    
    unsigned long oxygen = find_stat(0);
    reset();
    unsigned long co2 = find_stat(1);

    printf("%lu\n", oxygen * co2);
}