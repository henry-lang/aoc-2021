package main

import (
	"fmt"
	"bufio"
	"log"
	"os"
	"strings"
	"strconv"
	"sort"
)

func intArrToString(freqs []int) string {
	var strs []string
	for _, num := range freqs {
		strs = append(strs, strconv.Itoa(num))
	}
	return strings.Join(strs, "")
}

func intArrToInt(arr []int) (int, error) { // lol
	return strconv.Atoi(intArrToString(arr))
}

func main() {
	freqMap := map[string]int {"467889": 0, "89": 1, "47788": 2, "77889": 3, "6789": 4, "67789": 5, "467789": 6, "889": 7, "4677889": 8, "677889": 9}
	count := 0

	file, err := os.Open("./input/8.txt")
	if err != nil {
		log.Fatal(err)
	}
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        split := strings.Split(scanner.Text(), " | ")
		clues := strings.Split(split[0], " ")
		digits := strings.Split(split[1], " ")
		freqs := []int{0, 0, 0, 0, 0, 0, 0}
		//             a  b  c  d  e  f  g
		for _, clue := range clues {
			for _, char := range clue {
				freqs[char - 'a']++
			}
		}
		
		var final []int
		for _, digit := range digits {
			var digitFreqs []int
			for _, char := range digit {
				digitFreqs = append(digitFreqs, freqs[char - 'a'])
			}
			sort.Ints(digitFreqs)
			mapped := freqMap[intArrToString(digitFreqs)]
			final = append(final, mapped)
		}
		parsed, _ := intArrToInt(final)
		count += parsed
    }

	fmt.Println(count)
}