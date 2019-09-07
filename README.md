# gan-rsuite

The original number of epochs is `5,000`.
Originally there is no seed to "control" the randomness in `numpy` or `PyTorch`


## Observations
* The maximum number of iterations tried is `10`; the minimum in `1`.
Each iteration produces a new distribution sample.

* We can say that definitely is not a good idea to go through epochs lower than 1000 because they start presenting bimodalism. A minimum acceptable number of epochs seems to be 1250-1350.



* There is an impact on the speed of the `train()` loop when the algorithm is transported to R. At leats, the train loop takes 10 times as much as the loop in the native Python.



## Notebooks



## Scripts
- `notebooks/gan_torch_apply.R`: Script in R that replaces for loops with `lapply` functions.

- `notebooks/gan_noplot.py`: Script in Python without `matplotlib`.

- `notebooks/gan_torch.py`: Original script in Python with plotting capability.

- `notebooks/gan_torch.R`: Original GAN script converted from Python to R. It uses for loops.

- `notebooks/py_function.py`: Script holder for miscelaneous Python functions such as `fivenum`.


## Jupyter notebooks
- `notebooks/test GAN with no-plot.ipynb`: GAN script without matplotlib.

- `notebooks/test GAN with with plot.ipynb`: GAN script with matplotlib.


## Python imports in R
Under folder `inst/python` of package `gan.rtorch`.
