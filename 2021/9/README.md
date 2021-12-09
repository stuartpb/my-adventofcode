# Advent of Code 2021, Day 9: Low Basins

https://adventofcode.com/2021/day/9

## Synopsis

Given a grid of heights, find the sum plus count of all lowest points (Part 1), and the product of the three largest areas (Part 2).

## Mistakes

I failed PArt 1 many times because I didn't read the description of the value it was looking for closely enough: first I found the count, then the sum, and only after having given a half-dozen wrong answers did I notice it was looking for the sum of *one plus each depth* (ie. the count plus the sum).
