input = open("./input/14.txt")

poly = split(input |> readline, "")
input |> readline # Skip linebreak

pairs = Dict()

for line ∈ input |> readlines
    key, val = split(line, " -> ")
    pairs[key] = val
end

for i ∈ 1:10
    for (index, char) ∈ poly[begin:end-1] |> enumerate
        insert!(poly, 2index, pairs[char * poly[2index]])
    end
end

letters = unique(poly)
map = Dict([(i, count(x->x == i, poly)) for i in letters]) # Thank you stack overflow

println(findmax(map)[1] - findmin(map)[1])

close(input)