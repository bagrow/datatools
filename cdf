#!/usr/bin/env python

# cdf.py
# Jim Bagrow
# Last Modified: 2011-02-27

import sys, os

if __name__ == '__main__':
    
    data = [ float(x) for x in sys.stdin.readlines() ]
    
    N = len(data)
    
    Y = [ 1.0*(x+1)/N for x in range(N) ]
    
    for x,y in zip(sorted(data),Y):
        print x,y





