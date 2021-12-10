# Advent of Code 2017, Day 10: Knot Hash

https://adventofcode.com/2017/day/10

## Synopsis

Given a sequence of numbers (Part 1) or bytes (Part 2), compute the "hash" of the sequence by reversing and shifting byte values according to that sequence.

## Challenges

Writing this for the world of Lua's 1-based array indexing was, admittedly, more of a challenge than if I'd gone with a language having 0-based indexing, particularly considering how I wrote the `reverse` function to respect circular indices. If I change the signature of `reverse` to only take a length, I would simplify the most complex parts of my code significantly.
