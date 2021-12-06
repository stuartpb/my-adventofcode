# Advent of Code 2021, Day 6: Lanternfish

https://adventofcode.com/2021/day/6

## Synopsis

We're calculating how many immortal lanternfish exist after a certain number of days, given an initial set of fish that spawn new fish after a given number of days.

Part 1 calculates the number after 80 days, by tracking every single fish; Part 2 calculates it after 256 days, by tracking number of fish per day.

## Trouble

Some of the mistakes I made:

- Getting the offset wrong for new fish spawn cycles (it should be +9, but I had +8)
- Accidentally submitting the answer for the example input

I think I also messed up my initial entry by mistyping it or something - after looking at my code for some time trying to figure out why my answer was rejected, I copy-pasted it again and it worked.
