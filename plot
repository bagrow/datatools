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
  -p             : Passes a string to gnuplot's plot directive.  The
                   subsequent arg must be valid gnuplot.  For example 
                   -p 'with lines' will plot the XY-data using lines instead
                   of linespoints.
  -c             : Passes a command to gnuplot.  The subsequent arg must be 
                   valid gnuplot.  The command will be run before gnuplot's 
                   plot is executed.  For example,
                   -c 'set xlabel "x"; set ylabel "y"' will label the graph.
  -lx  | --logx  : Use logarithmic x-axis.
  -ly  | --logy  : Use logarithmic y-axis.
  -lxy | --logxy : Use double logarithmic axes.
  -l   | --log   : Shortcut for -lxy / --logxy.
  -m   | --multi : [not implemented]

Example:
  cat tutorial/xy.dat | %s -c 'set xr [0:1]' """ % (name,name)


if __name__ == '__main__':
    
    # parse args:
    argv = [ s.lower() for s in sys.argv[1:] ]
    if '-h' in argv or '--help' in argv:
        sys.exit( usage )
    A = set(argv)
    
    logX,logY = False,False
    if "-lx" in A or "--logx" in A:
        logX = True
    if "-ly" in A or "--logy" in A:
        logY = True
    if set(["-l","-lxy","--log","--logxy"]) & A:
        logX,logY = True,True
    
    cstr=''
    pstr='w lp pt 4'
    for i,arg in enumerate(argv):
        if arg == "-p":
            pstr = argv[i+1]
        if arg == "-c":
            cstr = argv[i+1]
    
    
    fout = open("/tmp/file.tmp", 'w')
    fout.write( "".join(l for l in sys.stdin) )
    fout.close()
    
    logstr = ""
    if logX and logY:
        logstr = "set log xy"
    elif logX and not logY:
        logstr = "set log x"
    elif logY and not logX:
        logstr = "set log y"
    
    cmd = """gnuplot << EOF
    set term x11 enhanced persist
    unset key
    %s
    %s
    plot '/tmp/file.tmp' %s
    """ % (logstr, cstr, pstr)
    
    os.system( cmd )
    os.system( "rm -f /tmp/file.tmp" )

