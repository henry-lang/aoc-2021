local function parseinput(input)
    local token = "([^,]+)"
    local tbl = {}
    for str in string.gmatch(input, token) do
            table.insert(tbl, tonumber(str))
    end
    return tbl
end

local crabs = parseinput(io.lines("./input/7.txt")())
table.sort(crabs)
local min = crabs[1]
local max = crabs[#crabs]

local best = 1e100 -- I don't know of a better way to get the max value
for i = min, max, 1 do
    local fuel = 0
    for j, crab in ipairs(crabs) do
        local dist = math.abs(i - crab)
        fuel = fuel + (1 + dist) * dist / 2
    end
    best = math.min(best, fuel)
end

print(math.floor(best))