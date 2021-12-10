import Foundation

let pairs: [Character : Character] = [
    "(": ")",
    "[": "]",
    "{": "}",
    "<": ">"
]

let scores: [Character : Int] = [
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137
]

let missingScores: [Character : Int] = [
    ")": 1,
    "]": 2,
    "}": 3,
    ">": 4
]

var lines: [String] = []

if let path = Bundle.main.path(forResource: "./input/10", ofType: "txt") {
    do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        lines = data.components(separatedBy: .newlines)
    } catch {
        print(error)
    }
}

var totals: [Int] = []
for line in lines {
    var stack: [Character] = []
    var corrupted = false

    for token in line {
        if pairs[token] != nil {
            stack.append(token)
        } else if pairs[stack.last!] == token {
            stack.removeLast()
        } else {
            corrupted = true
            break
        }
    }

    if !corrupted {
        var total = 0
        for opening in stack.reversed() {
            total *= 5
            total += missingScores[pairs[opening]!]!
        }
        totals.append(total)
    }
}

totals.sort()
print(totals[totals.count / 2])