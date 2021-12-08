# Advent of Code 2019, Day 8: Layered Number Image

https://adventofcode.com/2019/day/8

## Synopsis

Given a series of pixel values representing layers of an image, find a checksum for a specific layer (Part 1), then display the image (Part 2).

Converting this to the puzzle solution requires visual character recognition that lies outside the scope of the included code - I just used my eyes.

## Connections

The construction of an image representing letters of a string was also used in Advent of Code 2016 Day 8.

## Usage

The image output by part2.lua, while technically correct, isn't too readable as a mix of '0' and '1' characters. Rather than complicate the script's output, I improve the UX for readability at the shell level:

```sh
lua part2.lua <input | tr 01 ' #'
```
