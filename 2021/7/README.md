# Advent of Code 2021, Day 7: Crab Submarines

https://adventofcode.com/2021/day/7

## Synopsis

Given a list of crab submarines (by X position) that can only move left or right, determine the cheapest position to move to when fuel consumption is linear (Part 1) and triangular (Part 2).

## Implementation notes

The N^2 approach here isn't the most efficient: the linear case can be solved by just calculating the mean, and the triangular case is close enough to the median that it can be used as the core heuristic to start a brief binary search (many users have reported the mean being the correct answer for their input).
