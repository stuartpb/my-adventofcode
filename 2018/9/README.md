# Advent of Code 2018, Day 9: Marble Circle Game

https://adventofcode.com/2018/day/9

## Synopsis

The elves play a game that involves a lot of insertions and deletions

In Part 2, the elves want to simulate a game that's 100 times longer/bigger.

## Approach

Part 1 uses the naive implementation, where all marbles are stored in an array. This ends up having scalability issues as the game goes on, and more and more marbles need to be moved each turn.

Part 2 uses a linked list approach to simulate a game that's 100 times larger: this still requires a few hundred megabytes of free RAM, meaning I have to use a more robust machine than my 1 GB VM (where most of that is dedicated to running code-server) to run it.

Indeed, after installing GNU time (`sudo pacman -S time`), on a machine with sufficient resources, `\time -f %M lua part2.lua <input` shows that the complete execution uses over a full gigabyte of memory.
