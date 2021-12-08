package main

import (
	"fmt"
	"bufio"
	"log"
	"os"
	"strings"
)

func main() {
	count := 0

	file, err := os.Open("./input/8.txt")
	if err != nil {
		log.Fatal(err)
	}
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        split := strings.Split(scanner.Text(), " | ")
		digits := strings.Split(split[1], " ")
		for _, digit := range digits {
			switch len(digit) {
			case 2, 3, 4, 7:
				count++
			}
		}
    }

	fmt.Println(count)
}