# Advent of Code 2015, Day 10: Look and Say

https://adventofcode.com/2015/day/10

## Synopsis

Given an initial sequence, find the length of the string after 40 (Part 1) or 50 (Part 2) iterations of the Look and Say transformation.

## Implementation

I initially attempted this with direct concatenation to an empty string, but this started to drag even for 40 iterations; hence the use of 'buf' here, which avoids the churn of constantly interning and garbage-collecting intermediate strings (as noted in Programming in Lua [since the first edition](https://www.lua.org/pil/11.6.html))

Technically, the best way to do this would be to maintain a double-buffer swapping solution and never serialize to string: I initially thought that might pose a complication for run lengths above 9, before I realized the input is compliant with the rule that no run length in the sequence ever goes above 3 (as the same digit will never appear in two consecutive groups).
