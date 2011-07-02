#!/usr/bin/env python

# plot
# Jim Bagrow
# Last Modified: 2011-07-01

import sys, os

name = os.path.basename(sys.argv[0])
usage = \
"""Usage: %s [options]

Plot XY-data received from STDIN.

Options:
  -p              : Passes a string to gnuplot's plot directive.  The
                    subsequent arg must be valid gnuplot.  For example 
                    -p 'with lines' will plot the XY-data using lines instead
                    of linespoints.
  -c              : Passes a command to gnuplot.  The subsequent arg must be 
                    valid gnuplot.  The command will be run before gnuplot's 
                    plot is executed.  For example,
                    -c 'set xlabel "x"; set ylabel "y"' will label the graph.
  -e   | --errors : Shorthand for using errorbars.  The plot string 'with 
                    yerrorlines' is used.  This overrides any string given 
                    using -p. Note that gnuplot requires three or four columns
                    of input to render errorbars.
  -lx  | --logx   : Use logarithmic x-axis.
  -ly  | --logy   : Use logarithmic y-axis.
  -lxy | --logxy  : Use double logarithmic axes.
  -l   | --log    : Shortcut for -lxy / --logxy.
  -s   | --shared : Plot multiple curves that share the same X-values. This 
                    assumes that each line of the data received from STDIN is
                    of the form 'x1 y1 y2 y3 ...' so that curves 'x1 y1, ...',
                    'x1 y2, ...', ... can be displayed on a single plot.

Example:
  cat tutorial/xy.dat | %s -c 'set xr [1:10]' """ % (name,name)


if __name__ == '__main__':
    
    # parse args:
    argv = [ s.lower() for s in sys.argv[1:] ]
    if '-h' in argv or '--help' in argv:
        sys.exit( usage )
    A = set(argv)
    
    logX,logY = "",""
    shared = False
    if (set(["-lx","--logx"]) & A) or name == "logxplot":
        logX = "set log x"
    if set(["-ly","--logy"]) & A   or name == "logyplot":
        logY = "set log y"
    if set(["-l","-lxy","--log","--logxy"]) & A or name == "logplot":
        logX,logY = "set log x","set log y"
    
    
    cstr=''
    pstr='w lp pt 4'
    for i,arg in enumerate(argv):
        if arg == "-p":
            pstr = argv[i+1]
        if arg == "-c":
            cstr = argv[i+1]
    if '-e' in A or '--error' in A:
        pstr = 'w yerrorlines'
    
    fileout = "/tmp/file.tmp"
    fout = open(fileout, 'w')
    fout.write( "".join(l for l in sys.stdin) )
    fout.close()
    
    plotstr = "plot '%s' %s" % (fileout,pstr)
    if shared:
        N = len( open(fileout).readline().strip().split() )-1
        for i in xrange(1,N):
            plotstr += ", '%s' u 1:%i %s" % (fileout, i+2, pstr)
    
    cmd = """gnuplot << EOF
    set term x11 enhanced persist
    unset key
    %s
    %s
    %s
    %s
    """ % (logX,logY, cstr, plotstr)
    
    os.system( cmd )
    os.system( "rm -f %s" % fileout )

