local function parseinput(input)
    local token = "([^,]+)"
    local tbl = {}
    for str in string.gmatch(input, token) do
            table.insert(tbl, tonumber(str))
    end
    return tbl
end

local function getfuel(dist)
    local fuel = 0
    for i = 1, dist, 1 do
        fuel = fuel + i
    end
    return fuel
end

local crabs = parseinput(io.lines("./input/7.txt")())
table.sort(crabs)
local min = crabs[1]
local max = crabs[#crabs]

local best = -1
for i = min, max, 1 do
    local fuel = 0
    for j, crab in ipairs(crabs) do
        fuel = fuel + getfuel(math.abs(i - crab))
    end
    if best == -1 or fuel < best then
        best = fuel
    end
end

print(best)