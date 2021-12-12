# Advent of Code 2016, Day 11: Chips and Generators

https://adventofcode.com/2016/day/11

## Synopsis

Given a list of floors with radioisotope generators and thermoelectric microchips (one of each per element), find the minimum number of steps to get everything to the top floor (plus a couple more pairs on the bottom floor for Part 2).

## Remarks

This is *way* harder than the other puzzles, and the first one it took me longer to do than the day it was on (working on it into 2021-12-12).

## Issues

At one point, I was trying to diagnose the `fryfree` function:

```lua
print('fry?', gens, chips, chips:match('[^'..gens:lower()..']'))
    if gens ~= '' and chips:match('[^'..gens:lower()..']') then
```

I would get the error `lua: ./part1.lua:6: malformed pattern (missing ']')`, and it took me a few minutes to figure out what was going on: when `gens` is empty (which avoids the match pattern in the conditional), the exclusion pattern string becomes `[^]`, which Lua interprets like `[^%]` with no closing brace (similar to how it handles a hyphen at the beginning of the character set literally).

## Normalization

Another issue I ran into is that my normalization originally used the order of the generators to determine the letter order, rather than the first occurence of either in order, thinking that the order was arbitrary, and this would let floor normalization be simpler (since it doesn't require collecting the individual characters).

What I neglected to consider is that this caused floors with chips and a subset of generators on a higher floor to be duplicated (ie. `abc;ABCDEF` would also appear as `bcd;ABCDEF`, `cde;ABCDEF`, etc.)

After that, my last optimization was that I forgot to use `step` instead of `steps` as the name of the iteration counter, so my "seen" filter never even came into play.

What's weird is that I discovered, by accident (I keep confusing `%a` with `%l` for "letter"), that the script seems to generate far fewer states per level if I sort the letter by the *chips*, rather than whichever comes first. Now that I think about it, I guess this makes sense: it's possible for an identical permutation to ger duplicated in either direction - but there's never a superset of chips to generators.

Looking at the log output for both ways, here's an example of a subset that gets duplicated when there are generators below chips:

```
forward 8  21% done ;ABCa;DEFG;defg;#bc; (246/1147)
forward 8  21% done ;ABCa;DEFG;cefg;#bd; (247/1147)
forward 8  21% done ;ABCa;DEFG;cdfg;#be; (248/1147)
forward 8  21% done ;ABCa;DEFG;cdeg;#bf; (249/1147)
forward 8  21% done ;ABCa;DEFG;cdef;#bg; (250/1147)
```

When sorting by chips, this can only be represented as `;ABFa;CDEG;bcde;#fg;`.

## Further optimization

This would probably go a lot faster if I localized all the string calls that are OOP-style here. I could also bake the chip-based sorting in a little more (not call `lower` on the lower string in order creation, replace the gmatch + insert + sort + concat for lowers with a `gsub('%L','')` in `floormalize`...)

Actually, though, looking again, even sorting by chips, there are still redundancies:

```
forward 5  44% done ;#ADEa;BCFGbc;defg;; (23/52)
forward 5  46% done ;#ADFa;BCEGbc;defg;; (24/52)
```

The best serialization would be something with a natural symmetry to the representation, like tracking the number of chips on a floor by what floor their generator is on:

```
1;1=1;2=2;1=2,2=2;;
```

(Note that the elevator position here is prepended to the string.) 

A floor would get the number of generators on it by matching `floornum .. '=(%d+)'`, and would iterate through all possible moves by checking what happens when you move a generator, chip, or two of one or one of each, for each floor where the other end of a pair is present. The validity of a state here would be to check that a change doesn't leave more generators on the floor than there are chips paired to generators on that floor.

However, I've already got a working solution here; if I'm going to spend more time optimizing this, it'll be by coming back to it later.

Indeed, now that I think about it, that "one or two of each type and one of both" logic could probably be used as the same kind of optimization to avoid creating redundant states in this code.
