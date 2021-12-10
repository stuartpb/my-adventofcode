# Advent of Code 2019, Day 10: Asteroid Laser Station

https://adventofcode.com/2019/day/10

## Synopsis

Given a map of asteroids, find the asteroid with a direct line-of-sight to the most asteroids (Part 1), then find the coordinates of the 200th asteroid it would destroy by sweeping a line clockwise from the top (Part 2).

## Mistakes

I ran into trouble for Part 2 because I used Lua's native 1-based indexing for the coordinates internally, and forgot to translate back to 0-based for the answer.
