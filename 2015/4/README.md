# Advent of Code 2015, Day 4: The AdventCoin Miner

https://adventofcode.com/2015/day/4

## Synopsis

We need to find MD5 sums with a prefix of 5 or 6 zeroes for the given input, plus an incrementing decimal counter.

## Solution

I don't want to pull in external dependencies for Lua to brute-force MD5 sums, so I started out trying to solve this one by repeatedly calling an md5 sum program with Bash (part1.sh).

That didn't work (too slow), so I went with writing it in Rust, based on an updated version of the code in [this Gist](https://gist.github.com/gkbrk/2e4835e3a17b3fb6e1e7), with a non-hard-coded input.
