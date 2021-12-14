# Advent of Code 2015, Day 12: JSON Sum

https://adventofcode.com/2015/day/12

## Synopsis

Given a JSON document, find the sum of all numbers (Part 1), not counting the children of any object with a value of "red" (Part 2).

## Implementation

After seeing that the input was JSON, I was all ready to switch to a language with a native JSON library, but after reading the puzzle spec, this was actually easier to solve in Lua without parsing the JSON at all.
