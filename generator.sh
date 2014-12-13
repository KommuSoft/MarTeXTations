#!/bin/bash
ifl=$1
ofl=$(basename "$1" ".md")
ofl="$ofl.htm"
bash makepresentation.sh < "$ifl" > "$ofl"
