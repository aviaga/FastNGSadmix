#!/bin/bash
awk '{
  split($1, a, "/"); split(a[length(a)], b, "_");
  split($2, c, "/"); split(c[length(c)], d, "_");
  print b[1], d[1], $3, $4, $5, $6
}' "$1" > "$1.tmp"

mv "$1.tmp" "$1"
