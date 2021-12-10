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

var lines: [String] = []

if let path = Bundle.main.path(forResource: "./input/10", ofType: "txt") {
    do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        lines = data.components(separatedBy: .newlines)
    } catch {
        print(error)
    }
}

var score = 0
for line in lines {
    var stack: [Character] = []

    for token in line {
        if pairs[token] != nil {
            stack.append(token)
        } else if pairs[stack.last!] == token {
            stack.removeLast()
        } else {
            score += scores[token]!
            break
        }
    }
}

print(score)