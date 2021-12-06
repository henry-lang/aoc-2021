import 'dart:io';

const rounds = 256;

void main() async {
    var fish = {for (var i = 0; i < 9; i++) i: 0};
    (await File('./input/6.txt').readAsString()).split(',').forEach((num) => fish.update(int.parse(num), (v) => v + 1));
    
    for(var i = 0; i < rounds; i++) {
        var newFish = 0;
        fish.forEach((timer, count) {
            if(timer == 0) {
                newFish = count;
            } else {
                fish.update(timer - 1, (_) => count);
                if(timer == 8) fish.update(timer, (_) => 0);
            }
        });
        fish.update(6, (existing) => existing + newFish);
        fish.update(8, (existing) => existing + newFish);
    }

    print(fish.values.reduce((sum, count) => sum + count));
}