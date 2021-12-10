# Advent of Code 2021, Day 10: Mismatched Brace Scoring

https://adventofcode.com/2021/day/10

## Synopsis

Given a list of improperly-paired braces, find arbitrary scores for each line with an improperly-matched closing brace (Part 1) and the middle score for the completion sequence of each line with missing braces (Part 2).

## Abandoned approach

I initially tried to solve this by recursing through the list with `line:match('%b'..open..ends[open]..'()')` at the beginning of each group (finding unmatched strings when the group cannot be completed), before I remembered having solved nesting-brace problems like this before, and that they're trivially solved by iterating through the string with a stack. (Maybe that's why everyone in the top 100 got two stars within about 8 minutes: I also suspect there'll probably be a puzzle like this in past years that I haven't gotten to yet.)
