# Advent of Code 2016, Day 5: Per-Character Password Cracking

https://adventofcode.com/2016/day/5

## Synopsis

We have to crack passwords based on rules involving the lowest MD5 sums with five zeroes for the given input.

## Solution

This has the same MD5-cracking characteristics as the AdventCoin miner from 2015 Day 4, so I reused my Rust code from that.

Note the use of pre-newline output flushing, to fulfill the bonus-points criteria specified in Part 2:

> Be extra proud of your solution if it uses a cinematic "decrypting" animation.
