Datatools
=========

A collection of small scripts for quickly plotting and munging data from the
command line.  Supports basic statistics, histograms, and CDFs.  An importable
python module is also available: see `python/` for more.


Examples
========

    $ cat data.txt | mean
    $ python gen_xy.py | plot
    $ cat ages.txt | count | plot
    $ cat xy.data.txt | aver | plot -c "set title xy" -p "w p"
    $ cat data.txt | awk '{if ($1>0) print $1}' | ccdf | logplot
    $ cat samples.txt | ccdf | logplot -p 'w l, x**-1'

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
* gnuplot (and X11 terminal)
* python
    - numpy (version with fixed histogram normalization)
    - [networkx][] (only for `el2info` and `el2draw`)
    - [matplotlib][] (only for `el2draw`)

Todo
====

* Fix (c)cdf to only plot unique values.
* Support dumb terminal if x11 is not available?

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

[networkx]: http://networkx.lanl.gov
[matplotlib]: http://matplotlib.sourceforge.net
