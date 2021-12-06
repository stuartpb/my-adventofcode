# Advent of Code 2021, Day 5: Overlapping Vents

https://adventofcode.com/2021/day/5

## Synopsis

Given a list of lines (two X,Y coordinates separated by `->`), find the number of intersections. Part 1 only considers horizontal and vertical lines; Part 2 includes the rest, which are diagonal.

## Connections

For Part 1, I considered reusing my solution for 2018 Day 3 (overlapping rectangular patches), and if I had been doing this at midnight I probably would have.

## Mistakes

When tackling Part 2 (where it's pointed out that all non-horizontal/vertical lines are diagonal), I initially kept an optimization I had made for Part 1 (putting the X and Y coordinates in order). For the given example, this caused my map of overlapping points to look like the one on the right, instead of the one on the left:

```
1.1....11.   2.1....1..
.111...2..   .211...1..
..2.1.111.   ..3.11.1..
...1.2.2..   ...2.111..
.112313211   .112312311
...1.2....   .....2..1.
..1...1...   ......2...
.1.....1..   .......2..
1.......1.   ........2.
222111....   222111....
```
