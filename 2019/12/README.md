# Advent of Code 2019, Day 12: 3D Moon Cycles

https://adventofcode.com/2019/day/12

## Synopsis

Given a list of three-dimensional coordinates that gravitate toward each other, find the total "energy" of the system after 1000 steps (Part 1) and how many steps it takes until the system repeats itself.

## Implementation

I had to check the Reddit thread for the hint to solving Part 2: each of the dimensions operates independently of the others, so the solution to getting the cycle length of the entire system (an intractibly-large number) is to find the cycle length of each axis, then find the least common multiple of the three.

## Wrong Answers

In classic fashion, I missed initially that a moon's energy is the sum of its absolute position values **times** (not plus) the sum of its absolute velocity values.

I also missed that Part 1, despite showing 100 steps for its second example, asks for an answer reached after *1000* steps.

## Other Dumb Mistakes

In implementing my slightly-shorter-loops optimization for Part 2 (skipping moons compared against themselves), I accidentally wrote `i+i` instead of `i+1`, and didn't catch this until after I'd inserted about half a dozen print statements. I think this wasn't even the first time I'd made that mistake, either.
