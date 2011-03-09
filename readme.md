Datatools
=========

A collection of small scripts for quickly plotting and munging data from the
command line.  Support for basic statistics, histograms, and CDFs is included.


Examples
========

    $ cat data.txt | mean
    $ cat data.txt | awk '{if ($1>0) print $1}' | ccdf | plot


Install
=======
Get the git repository

    $ git clone <url>

Then add the `datatools` directory to your path.  For example, put

    if [ -d "$HOME/datatools" ]; then
        export PATH=~/datatools:$PATH
    fi

in your bashrc.


Requirements
============

* bash
* awk
* gnuplot
* python
    - numpy (version with fixed histogram normalization)


Todo
====

* Fix (c)cdf to only plot unique values.
* Real help and documentation.


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

