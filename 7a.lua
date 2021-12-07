local function parse_input(input)
    local token = "([^,]+)"
    local tbl = {}
    for str in string.gmatch(input, token) do
            table.insert(tbl, tonumber(str))
    end
    return tbl
end

local crabs = parse_input(io.lines("./input/7.txt")())
table.sort(crabs)
local min = crabs[1]
local max = crabs[#crabs]

local fuel = 0
for j, crab in ipairs(crabs) do
    fuel = fuel + math.abs(crabs[math.floor(#crabs / 2)] - crab)
end

print(fuel)