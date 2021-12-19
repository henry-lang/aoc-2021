def main
    input = File.read('./input/13.txt').split("\n")
    seperator = input.index('')

    points = input[0...seperator].map{|d| d.split(',').map(&:to_i)}
    folds = input[seperator + 1..-1].map{|f| f.split('along ').last.split('=')}.each{|f| f[1] = f[1].to_i}

    width = points.map{|d| d[0]}.max + 1
    height = points.map{|d| d[1]}.max + 1
    paper = Array.new(height) {Array.new(width){'.'}}

    points.each do |(x, y)|
        paper[y][x] = '#'
    end

    folds.each do |(axis, pos)|
        case axis
        when 'x'
            paper = fold_x(paper, pos)
        when 'y'
            paper = fold_y(paper, pos)
        end
    end
    paper.each{|l| puts l.reverse.join('')}
end

def overlap(bottom, top) 
    top.each_with_index do |arr, col|
        arr.each_with_index do |c, row|
            if c == "#" then bottom[col][row] = c end
        end
    end

    return bottom
end

def fold_x(paper, x)
    to_fold = paper.map{|row| row[0...x].reverse()}
    paper = paper.map{|row| row[x + 1..-1]}
    
    return overlap(paper, to_fold) 
end

def fold_y(paper, y)
    to_fold = paper[y + 1..-1].reverse
    paper = paper[0...y]

    return overlap(paper, to_fold) 
end

main