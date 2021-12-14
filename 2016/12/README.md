# Advent of Code 2016, Day 12: Assembunny Code

https://adventofcode.com/2016/day/12

## Synopsis

Given a list of cpy/inc/dec/jnz operations on 4 registers, find the ending value of register `a` when all registers are initialized to 0 (Part 1) except `c`, which is initialized to 1 (Part 2).

## Implementation

Being that it would otherwise have all but one line identical, Part 2 has some optimizations I considered for Part 1; I measure the difference at roughly 7 vs 9.5 seconds.
