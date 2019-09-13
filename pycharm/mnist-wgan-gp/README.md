# mnist-wgan-gp



* Get rid of warnings by removing `volatile=True`
* Fix `urllib.request.urlretrieve(url, filepath)` by adding method `request`.
* Fix issues with dictionaries in 3.7. Add `list()` to couple of commands under loop `for name, vals in _since_last_flush.items():` in `plot.py`.
* add `encoding='latin1'` to `pickle.load`
* Force couple of calculations to integer

* Replace cPickle

* add folder `./tmp/mnist`. Otherwise, saving images fail

* Fix Python 2.7 print() problem in scripts.
* Replace `xrange` with `range`
* Install Python packages `imageio`
* Use `r-torch` as the interpreter environment