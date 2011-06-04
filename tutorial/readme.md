Types of data
=============

Datatools deals primarily with three types of data, all of which are read from
STDIN:
    
1. Distribution data or __X-data__ is simply a single column of values.  These may
   represent samples drawn from a probability distribution, for example.

2. __XY-data__ consists of two columns of values (of the same length).  These may
   be plotted directly to make a scatter plot.  There may be multiple (X,Y)
   pairs that have the same X-value, if multiple measurements were performed
   for a given x-value, for example.  In fact, dealing with this situation
   (averaging all Y-values for each given X-value) is one of the most useful
   features of datatools (see `aver`).

3. __Edgelists__ also consist of two columns, but these represent the edges of an
   undirected graph or network.  For example:
    
        node1  node2
        node2  node3
        node3  node1
    
   encodes a simple triangle, each link on its own line.  Edgelists are read by
   `el2info` and `el2dd`, which print a number of network summary statistics and
   compute the degree distribution, respectively.

 If one has more involved data, multiple columns for example, tools such as `awk`
 or `sed` may be used to extract relevant subsets of data.  This makes datatools
 quite flexible.


Simple statistics from X-data
=============================

One can compute simple statistics by piping a column of numbers, sampled from a
probability distribution for example, into `min`, `max`, `sum`, `mean`, and
`stdv`.  A nice overview of the data can be displayed using `summary`.


Transforming data
=================

Much of datatools functionality involves transforming one type of data to
another so that it may be plotted, etc.  For example, `bin` computes the
histogram of X-data, returning XY-data where the X-values are the centers of
bins and the Y-values are the number (or fraction) of original datapoints that
fall within that bin.  Other functions that read X-data and return plottable
XY-data are `logbin`, `count`, `cdf`, and `ccdf`.


Plotting data
=============

Given XY-data, perhaps transformed by datatools functions such as `bin` or `aver`,
one can plot this data using `plot`, `logplot`, `logxplot`, and `logyplot`.


Sample data
===========

This directory contains some example data files to experiment with.  Try:

    $ cat xy.dat | aver 100 | plot
    $ cat x.dat | mean
    $ cat x.ints.dat | count | plot -l 'w lp'
    $ cat karate.edgelist | el2info

The file `karate.edgelist` contains the Zachary Karate Club:

W. W. Zachary, An information flow model for conflict and fission in small
groups, Journal of Anthropological Research 33, 452-473 (1977).


Getting help
============

All of the scripts contain help statements to make it easy to look up their options
and determine functionality.  For example, running:
    
    $ aver -h
    
returns:
    
    Usage: aver [-u|--uniq|--unique] [-l|--log] [-e|--errorbars] [number of bins] 
    
    Average/smooth XY-data received from STDIN by binning the X-values then, for
    each x-bin, compute the mean of all the y-values within that bin.  Using -u,
    --uniq, or --unique will compute the mean of all corresponding y-values for
    each unique x-value.  This is useful for integer-valued x-data, for example,
    where binning isn't necessary. Use -l or --log for logarithmically-spaced
    x-bins.  Use -e or --errorbars to include a third column containing the
    standard deviation of each x bin's y-values.
    
    Example:
    cat tutorial/xy.dat | aver | plot

All help strings can be accessed using the `-h` or `--help` flags from the
command line.
