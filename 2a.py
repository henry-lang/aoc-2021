data = [tuple(line.split(" ")) for line in open("input/2.txt").read().split("\n")[:-1]]

horiz = 0
depth = 0

for (dir, units) in data:
    if(dir[0] == "f"):
        horiz += int(units)
    if(dir[0] == "d"):
        depth += int(units)
    if(dir[0] == "u"):
        depth -= int(units)

print(horiz * depth)
