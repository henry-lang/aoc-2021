data = [int(line) for line in open("./input/1.txt").read().split("\n")[:-1]]
count = 0

for i, value in enumerate(data):
    count += (value > data[i - 3])

print(count)
