# Advent of Code 2019, Day 5: Intcode II

https://adventofcode.com/2019/day/5

## Synopsis

This is a continuation of the Intcode computer from Day 2, with two new opcodes in Part 1 and four more in Part 2:

- 3 (input)
- 4 (output)
- 5 (jump if not zero)
- 6 (jump if zero)
- 7 (set if less than)
- 8 (set if equal)

This also introduces "parameter" flags for each opcode, as digits before the last 2, which define "immediate mode" flags.

## Run format

Note that, due to the introduction of a separate input stream in the Intcode computer's implementation, the program instructions are read from a filename given in the command line arguments (using the filename 'input' by default); rather than simulate input with hardcoded instructions, we use stdin to read inputs to the Intcode program.

## Example sketch

trying to follow expected Intcode behavior, I typed out the first few instructions as a sort of pseudo-assembly:

```
3 (read:1) -> 225 = 1
1 (225:1)+(6:1100) -> 6 = 1101
1101 (1)+(238) -> 225 = 239
104 (print:0)
1102 (31)*(68) -> 225 = 2108
1001 (13:31)+(87) -> 224 = 118
1001 (224:118)+(118) 
```
