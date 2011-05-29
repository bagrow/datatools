#!/usr/bin/python

# bin
# Jim Bagrow
# Last Modified: 2011-05-29

"""
    This file is part of Datatools.
    
    Datatools is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    Datatools is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with Datatools.  If not, see <http://www.gnu.org/licenses/>.
"""

import sys, os, numpy
import warnings

name = os.path.basename(sys.argv[0])
usage = \
"""Usage: %s [number of bins]

Compute the histogram of the data received from STDIN using linearly spaced
  bins.  If the number of bins is unspecified, an estimate is used based on the
  number of data points.
Example:
  cat vals.txt | %s 200 | plot -c "set xlabel 'x'; set ylabel 'Pr(x)';" """ % (name,name)

error = "Number of bins must be an integer, run `%s --help` for info." % name

if __name__ == '__main__':
    
    # eventually make this take a file and num_bins (bin width?)
    if "-h" in sys.argv or "--help" in sys.argv:
        sys.exit(usage)
    try:
        num_bins = int(sys.argv[1])
    except IndexError:
        num_bins = None
    except ValueError:
        sys.exit(error)
    
    data = [ float(x) for x in sys.stdin.readlines() ]
    
    if num_bins is None:
        from math import sqrt
        num_bins = int(sqrt(len(data)))
    
    warnings.simplefilter("ignore", Warning)
    hist,bin_edges = numpy.histogram(data, bins=num_bins, normed=True)
    bin_centers = bin_edges[0:-1] + 0.5*(bin_edges[1:] - bin_edges[0:-1])
    
    for b,h in zip(bin_centers, hist):
        print b, h
