Types of data
=============

Data tools deals primarily with three types of data, all of which are read from
STDIN:
    
1. Distribution data or X-data is simply a single column of values.  These may
   represent samples drawn from a probability distribution, for example.

2. XY-data consists of two columns of values (of the same length).  These may
   be plotted directly to make a scatter plot.  There may be multiple (X,Y)
   pairs that have the same X-value, if multiple measurements were performed
   for a given x-value, for example.  In fact, dealing with this situation
   (averaging all Y-values for each given X-value) is one of the most useful
   features of datatools (see `aver`).

3. Edgelists also consist of two columns, but these represent the edges of a
   graph or network.  For example:
    
        node1  node2
        node2  node3
        node3  node1
    
   encodes a simple triangle, each link on its own line.  Edgelists are read by
   `el2info` and `el2dd`, which print a number of network summary statistics and
   compute the degree distribution, respectively.

 If one has more involved data, multiple columns for example, tools such as awk
 or sed may be used to extract relevant subsets of data.  This makes datatools
 quite flexible.


Simple statistics from X-data
=============================

One can compute simple statistics by piping a column of numbers, sampled from a
probability distribution for example, into `min`, `max`, `sum`, `mean`, and
`stdv`. 


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

This directory contains some example data files to experiment with.

    $ cat xy.dat | aver 100 | plot
    $ cat x.dat | mean
    $ cat x.ints.dat | count | plot -l 'w lp'
    $ cat karate.edgelist | el2info

The file `karate.edgelist` contains the Zachary Karate Club:

W. W. Zachary, An information flow model for conflict and fission in small
groups, Journal of Anthropological Research 33, 452-473 (1977).


