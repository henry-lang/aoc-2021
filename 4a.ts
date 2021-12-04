import * as fs from 'fs'

class Board {
    nums: number[] = []

    checkWin(): boolean {
        for (let i = 0; i < 5; i++) {
            const row = this.nums.slice(i * 5, i * 5 + 5)
            const col = this.nums.filter((_, index) => (index - i) % 5 == 0)
            if (
                row.every(num => called.includes(num)) ||
                col.every(num => called.includes(num))
            ) {
                return true
            }
        }
        return false
    }

    getScore(): number {
        return (
            this.nums.reduce((total, current) => {
                if (!called.includes(current)) return total + current
                return total
            }, 0) * called.at(-1)
        )
    }
}

const input = fs
    .readFileSync('./input/4.txt')
    .toString()
    .split('\n')
    .filter(line => line != '')

const nums = input
    .shift()
    .split(',')
    .map(num => Number(num))

let boards: Board[] = []
let called: number[] = []

while (input.length > 0) {
    let board = new Board()
    for (let i = 0; i < 5; i++) {
        board.nums = [
            ...board.nums,
            ...input
                .shift()
                .trim()
                .split(/\s+/)
                .map(num => Number(num)),
        ]
    }
    boards.push(board)
}

nums.forEach(num => {
    called.push(num)
    boards.forEach(board => {
        if (board.checkWin()) {
            console.log(board.getScore())
            process.exit(0)
        }
    })
})
