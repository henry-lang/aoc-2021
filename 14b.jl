input = open("./input/14.txt")

template = input |> readline
input |> readline # Skip linebreak

pairs = Dict{String,String}()
nums = Dict{String,Int}()

for line ∈ input |> readlines
    key, val = split(line, " -> ")
    pairs[key] = val
    nums[key] = 0
end

chars = Dict(char => 0 for char ∈ pairs |> values |> unique)
init_nums = nums |> copy

for i ∈ 1:length(template) - 1 # Loop over template and populate initial nums and chars
    init_nums[template[i:i + 1]] += 1
    chars[template[i:i]] += 1
end
chars[template[end:end]] += 1

for i ∈ 1:40
    current = nums |> copy
    for (key, val) ∈ pairs
        current[key[1] * val] += init_nums[key]
        current[val * key[2]] += init_nums[key]
        chars[val] += init_nums[key]
    end
    global init_nums = current
end

vals = chars |> values
maximum(vals) - minimum(vals) |> println

close(input)