# 2019-12-05: Intcode Part 2

Note that, due to the introduction of a separate input stream in the Intcode computer's implementation for Part 2, the program instructions are read from a filename given in the command line arguments (using the filename 'input' by default); rather than simulate input with hardcoded instructions, we use stdin to read inputs to the Intcode program.

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