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
    $ cat xy.data.txt | aver | plot -c "set title xy" -p "w p"

Compute cumulative distribution of data and plot:

    $ cat data.txt | awk '{if ($1>0) print $1}' | ccdf | logplot
    $ cat samples.txt | ccdf | logplot -p 'w l, x**-1'

Fit a curve to data:

    $ cat tutorial/xy.dat | curvefit "A*sin(x/B)+C" B=3 --noplot --verbose

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

* bash
* awk
* [gnuplot][] (and X11 terminal)
* [python][] 2.x (probably 2.5+)
    - numpy (version with fixed histogram normalization)
    - [networkx][] (only for `el2info` and `el2draw`)
    - [matplotlib][] (only for `el2draw`)

Recent versions of OS X include everything but gnuplot, networkx, and
matplotlib.  Some knowledge of gnuplot is very helpful for customizing plot
appearance.

Todo
====

* Fix (c)cdf to only plot unique values.
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
