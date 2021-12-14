# Advent of Code 2021, Day 12: Cave Paths

https://adventofcode.com/2021/day/12

## Synopsis

Given a list of connected caves, find the number of paths between `start` and `end` where small caves (with lowercase names) are visited at most once (Part 1) or with no more than one visited twice (Part 2).

## Implementation

The implementation for Part 1 assumes there are no nodes with names that can be found in `start`, because that's true for my input and all the examples. If that were not the case, I'd implement the `dest ~= 'start'` rule from Part 2, or add a hack to the parsing that appends `'z'` to any cave named `st`, `ta`, `ar`, or `rt`.

## Diagnosing a mistake

I was seeing fewer paths than I was ex[ecting for Part 2, so I inserted this second line after the first:

```lua
    if dest == 'end' then total = total + 1
      print('start'..previous..',end')
```

Then ran this to find paths my code was missing:

```bash
./part2.lua <example | sort | comm -23 expected -
```

From there, I had the insights I needed to filter my debug watching to routes I knew were having trouble:

```lua
    if previous:match'^,A,b,A,c,' then print('?',previous,dest,double) end
```

From this, I realized that I was setting `double` outside the loop scope, meaning that the first destination to use double traversal caused all subsequent destinations to be treated as double-visited.
