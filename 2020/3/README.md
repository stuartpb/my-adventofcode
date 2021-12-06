# Advent of Code 2020, Day 2: Passwords Matching Policies

https://adventofcode.com/2020/day/2

## Synopsis

Each line of the input represents a "password" and a "policy" that password is expected to meet.

Part 1 prints the sum of passwords that have a number of the given letter in the range specified.

Part 2 prints the sum of passwords that have the given letter in only one of the positions specified.

## Misreadings

wrong/part2.lua interprets the two positions as a range that should only contain one instance of the letter; while this would make sense, it's not what the question asks for.
