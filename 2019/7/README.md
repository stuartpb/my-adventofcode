# Advent of Code 2019, Day 7: Intcode III - Amplifier Series

https://adventofcode.com/2019/day/7

## Synopsis

This ties together the previous 2 Intcode days to find the optimal program across multiple instances of the given program, within a set of arbitrary inputs; Part 2 makes the inputs depend on the output from the other programs, continuously.

## Implementation notes

As of the changes made to support running I/O for Part 2, my Intcode implementation is starting to get a little hairy; I might end up rewriting it the next time Intcode comes into play.

While this is technically a sound use for coroutine.wrap, it's also not strictly necessary, and coroutines do introduce complexity that doesn't have to be here.
