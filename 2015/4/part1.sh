#! /usr/bin/env bash
read input
nonce=0
while [[ $(echo -n "$input$nonce" | openssl md5) != 00000* ]]; do
  nonce=$((nonce + 1))
done
echo $nonce