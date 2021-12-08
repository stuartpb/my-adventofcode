# Advent of Code 2020, Day 8: Boot Loop

https://adventofcode.com/2020/day/8

## Synopsis

Given a series of assembly-like instructions for a "handheld game console", find the sum in the accumulator when executing before entering an infinite loop (Part 1), and find the sum in the accumulator after switching the one jmp/nop that sends the program into a loop (Part 2).

## Mistakes

For Part 2, I spent a long time going through my finite-procedure-finding procedure trying to figure out what was wrong when the answer page told me that my answer was too high.

There was nothing wrong with my finite-procedure-finding procedure - I just wasn't clearing the accumulator between runs.
