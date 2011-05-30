#!/usr/bin/python

# datatools.py
# Jim Bagrow
# Last Modified: 2011-05-28

"""
    docstring for datatools
"""


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

from math import sqrt
import numpy
import warnings


def _get_num_bins(data):
    return int(sqrt(len(data))) + 1


def aver(X, Y=None, unique=False, logbin=False, numbins=None):
    """docstring for aver"""
    
    if Y is None:
        X,Y = zip(*X)
    data = zip(X,Y)
    
    if unique is True:
        x2listy = {}
        for x,y in data:
            try:
                x2listy[x].append(y)
            except KeyError:
                x2listy[x] = [y]
        X_out = sorted(x2listy.keys())
        Y_out = [ numpy.mean(x2listy[x]) for x in X_out ]
    else:
        X,Y = zip(*data)
        
        # number of bins:
        if numbins is None:
            numbins = _get_num_bins(data)
        
        # get vector of bin edges:
        if logbin:
            minVal = numpy.log10(min(X)-1e-8) # safe?
            maxVal = numpy.log10(max(X)+1e-8)
            bin_edges = numpy.logspace( minVal, maxVal, numbins+1 )
        else:
            bin_edges = numpy.linspace( min(X),max(X), numbins+1 )
        
        # bin the data:
        bL,bR, data_in_bin, b = bin_edges[0],bin_edges[1], [], 0
        X_out, Y_out = [], []
        for x,y in sorted(data):
            if x > bR: # this x,y is in next bin, so finish off current bin
                X_out.append( 0.5*(bL+bR) )
                Y_out.append( numpy.mean(data_in_bin) )
                b += 1
                bL, bR = bin_edges[b], bin_edges[b+1]
                data_in_bin = []
            data_in_bin.append( y )
        X_out.append( 0.5*(bL+bR) )
        Y_out.append( numpy.mean(data_in_bin) )  # don't forget last bin!
    
    return X_out, Y_out


def bin(data, numbins=None):
    """docstring for bin"""
    
    # number of bins:
    if numbins is None:
        numbins = _get_num_bins(data)
    
    warnings.simplefilter("ignore", Warning)
    hist,bin_edges = numpy.histogram(data, bins=numbins, normed=True)
    bin_centers = bin_edges[0:-1] + 0.5*(bin_edges[1:] - bin_edges[0:-1])
    
    return list(bin_centers), list(hist)


def cdf(data):
    """docstring for cdf"""
    N = len(data)
    Y = [ 1.0*(x+1)/N for x in range(N) ]
    return sorted(data), Y


def ccdf(data):
    """docstring for ccdf"""
    N = len(data)
    Y = [ 1.0-1.0*(x+1)/N for x in range(N) ]
    return sorted(data), Y


def corrcoef(X,Y=None):
    """docstring for ccdf"""
    if Y is None:
        X,Y = zip(*X)
    return numpy.corrcoef(X,Y)[0,1]


def count(data):
    """docstring for count"""
    val2num = {}
    for x in data:
        try:
            val2num[x] += 1
        except KeyError:
            val2num[x] = 1
    X_out = sorted(val2num.keys())
    Y_out = [val2num[x] for x in X_out]
    return X_out, Y_out


def logbin(data, numbins=None):
    """docstring for logbin"""
    
    # number of bins:
    if numbins is None:
        numbins = _get_num_bins(data)
    
    min_data,max_data = min(data),max(data)
    bin_edges = numpy.logspace( numpy.log10(min_data), numpy.log10(max_data), numbins+1 )
    
    warnings.simplefilter("ignore", Warning)
    try: # deal with deprecated numpy behavior :(
        hist,bin_edges = numpy.histogram(data, bins=bin_edges, normed=True, density=True)
    except TypeError:
        hist,bin_edges = numpy.histogram(data, bins=bin_edges, normed=True)
    
    bin_centers = bin_edges[0:-1] + 0.5*(bin_edges[1:] - bin_edges[0:-1])
    return list(bin_centers), list(hist)


mean = numpy.mean
stdv = numpy.std


if __name__ == '__main__':
    pass

