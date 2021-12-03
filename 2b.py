data = [tuple(line.split(" ")) for line in open("input/2.txt").read().split("\n")[:-1]]

aim = 0
horiz = 0
depth = 0

for (dir, units) in data:
    if(dir[0] == "f"):
        horiz += int(units)
        depth += aim * int(units)
    if(dir[0] == "d"):
        aim += int(units)
    if(dir[0] == "u"):
        aim -= int(units)

print(horiz * depth)
