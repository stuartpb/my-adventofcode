# Advent of Code 2015, Day 4: The AdventCoin Miner

I don't want to pull in external dependencies for Lua to brute-force MD5 sums, so I started out trying to solve this one by repeatedly calling an md5 sum program with Bash (part1.sh).

That didn't work (too slow), so I went with writing it in Rust, based on an updated version of the code in [this Gist](https://gist.github.com/gkbrk/2e4835e3a17b3fb6e1e7), with a non-hard-coded input.
