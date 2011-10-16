Datatools
=========

A collection of small scripts for quickly plotting and munging data from the
command line.  Supports basic statistics, histograms, and [CDFs][].  An importable
python module is also available: see `python/` for more.


Examples
========

Compute summary statistics:

    $ cat data.txt | mean
    $ cat data.txt | stdv
    $ cat data.txt | summary

Plot data generated from script:

    $ python gen_xy.py | plot

Bin data and then plot:

    $ cat ages.txt | count | plot
    $ cat xy.data.txt | aver | plot -c "set title 'xy'" -p "with points"

Compute cumulative distribution of data and plot:

    $ cat samples.txt | ccdf | plot
    $ cat data.txt | awk '{if ($1>0) print $1}' | ccdf | logplot --funcs 'x**-1'

Fit a (nonlinear) function to data:

    $ cat current_voltage.dat | curvefit "a0*exp(a1*x)"
    $ cat xy.dat | curvefit "A*sin(x/B)+C" B=3 --noplot --verbose
    $ cat tutorial/x.dat | bin | curvefit "A*exp(-x**2/B)"

All functions have help strings (use `-h` or `--help`):

    $ mplot -h
    $ el2info --help

See `tutorial/` for more information.

Install
=======

Get the git repository:

    $ cd
    $ git clone git://github.com/bagrow/datatools.git

Then add the `datatools` directory to your path.  For example, put

    if [ -d "$HOME/datatools" ]; then
        export PATH=~/datatools:$PATH
    fi

in your `bashrc`.


Requirements
============

* bash and awk (very common)
* [gnuplot][] (and X11 terminal)
* [python][] 2.x (probably 2.5+)
    - numpy (version with fixed histogram normalization, around 1.6)
    - [networkx][] (only if using `el2info` and `el2draw`)
    - [matplotlib][] (only if using `el2draw`)

Recent versions of, e.g., OS X include everything but gnuplot, networkx, and
matplotlib.  Some knowledge of gnuplot is very helpful for customizing plot
appearance as the `-p` and `-c` options use valid gnuplot code.

Todo
====

* ~~Fix (c)cdf to only plot unique values.~~ First send data through `stepize`.
* Support dumb terminal if x11 is not available?
* Eliminate numpy dependency?
* Unit tests?

License
=======

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

[CDFs]:       http://en.wikipedia.org/wiki/Empirical_distribution_function
[numpy]:      http://numpy.scipy.org/
[python]:     http://python.org/
[gnuplot]:    http://www.gnuplot.info/
[networkx]:   http://networkx.lanl.gov
[matplotlib]: http://matplotlib.sourceforge.net
