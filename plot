#!/bin/bash

PRECMD=''
LINCMD='w lp'
while getopts "c:l:" flag
do
    case "$flag"  in
        c) PRECMD=$OPTARG;;
        l) LINCMD=$OPTARG;;
      [?]) echo "bad commandline flags" & exit;;
    esac
done

cat /dev/stdin > file.tmp

gnuplot << EOF
set term x11 enhanced persist
unset key

$PRECMD
plot 'file.tmp' using 1:2 $LINCMD
EOF

rm -f file.tmp
