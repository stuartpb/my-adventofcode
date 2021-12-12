# Advent of Code 2021, Day 11: Flashing Octopuses

https://adventofcode.com/2021/day/11

## Synopsis

Given a grid of values, where any value above 9 increments the values around it and resets to 0, count how many times values go above 9 in the first hundred steps (Part 1), and how many steps until every value goes above 9 at once (Part 2).

## Mistakes

I initially clamped the "ready to flash" values to 9, not realizing that this makes it impossible to distinguish values that will flash *this* step from ones that will flash *next* step. Disappointing, especially considering how much effort I put into adding this clamping: I probably wouldn't have made it into the top 100, but I would have had Part 1 done significantly earlier.

I also made the mistake of forgetting that `here` isn't the value that's getting set; my initial code had me setting `here = here + 1`, and then, even after correcting that to `row[x] = here + 1`, I still had a comparison against `here > 9` (which, honestly, is a completely unnecessary optimization anyway; doing one flashing iteration every step is not a major performance hit, especially since it saves one comparison each iteration in the initial incrementing).

Also, for Part 2, I accidentally removed my `flashing = nil` at the top of the flashing step after removing a debug `print` statement, causing an infinite loop. D'oh.
