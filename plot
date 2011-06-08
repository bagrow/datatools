#!/bin/bash

#  This file is part of Datatools.
#  
#  Datatools is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Datatools is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with Datatools.  If not, see <http://www.gnu.org/licenses/>.


usage(){
    name=`basename $0`
    echo -e "Usage: $name [-c \"gnuplot command(s)\"] [-l \"gnuplot plot option(s)\"]"
    echo -e ""
    echo -e "Read xy data from STDIN and plot."
    echo -e "  Flags -c and -l allow commands to be passed to gnuplot. They must be"
    echo -e "  valid gnuplot strings. The -c string is run just before the plot"
    echo -e "  command, while the -l string is run at the end of the plot command.\n"
    echo -e "Example:\n  cat f.txt | $name -c \"set xlabel 'x';set ylabel 'y'\" -l \"w lines\" "
	exit 1
}


PRECMD=''
LINCMD='w lp pt 4'
while getopts "c:l:h -help" flag
do
    case "$flag"  in
        c) PRECMD=$OPTARG;;
        l) LINCMD=$OPTARG;;
        h) usage;;
    -help) usage;;
      [?]) usage;;
    esac
done


cat /dev/stdin > /tmp/file.tmp

gnuplot << EOF
set term x11 enhanced persist
unset key

$PRECMD
plot '/tmp/file.tmp' $LINCMD
EOF

rm -f /tmp/file.tmp

