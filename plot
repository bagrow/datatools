#!/usr/bin/env python

# plot
# Jim Bagrow
# Last Modified: 2011-06-23

import sys, os

name = os.path.basename(sys.argv[0])
usage = \
"""Usage: %s [options]

Plot XY-data received from STDIN.

Options:
  -lx  | --logx    :
  -ly  | --logy    :
  -lxy | --logxy   :
  -l   | --log     :
  -p   | --plotstr :
  -c   | --cmdstr  :

Example:
  cat tutorial/xy.dat | %s -c 'set xr [0:1]' """ % (name,name)


if __name__ == '__main__':
    
    # parse args:


