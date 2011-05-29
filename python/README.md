datatools.py
============

A companion, importable python module for datatools, containing most of the
non-plotting functionality.  For plotting, [matplotlib][] is recommended.


Example
=======
    
    $ python
    >>> import datatools
    >>> import numpy, pylab
    >>> data = numpy.random.randn(1000)
    >>> X,Y = datatools.ccdf(data)
    >>> pylab.plot(X,Y)
    >>> pylab.show()


Install
=======
    
    $ cd /some/dir/datatools/python
    $ sudo python setup.py install

Note that `sudo` may not be needed.  Be sure to rerun `python setup.py install`
whenever the repository is updated.

Requirements
============

* numpy (version with fixed histogram normalization)


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


[matplotlib]: http://matplotlib.sourceforge.net

