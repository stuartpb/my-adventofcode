# Advent of Code 2015, Day 9: The Traveling Santa Problem

https://adventofcode.com/2015/day/9

## Synopsis

This is a [traveling salesman problem][1] to find the shortest (Part 1) or longest (Part 2) route between all the cities in a provided graph of symmetric distances.

[1]: https://en.wikipedia.org/wiki/Travelling_salesman_problem

## Implementation

Since the number of cities is low (8), the factorial approach is only 40320 iterations, so we use a plain brute-force algorithm.
