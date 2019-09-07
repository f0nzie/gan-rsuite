# CHANGES

## 0.0.3 (2019-09-06)
* Add new script `gan_noplot_params.py` that receives a parameter for the number of epochs.
* New notebook series 4 to study the distributions for real and fake data
* Print the mean and standard deviation at the end of each sample (10 samples)
* Take more measurements of `fivenum` of the resulting distribution
* PLot histograms of the real and fake data

## 0.0.2 (2019-09-06)
* Use Python code without matplotlib for ciomparative results: Rmarkdown vs Jupyter vs PyCharm.
* Take measurements at different `epochs`.
* Test GANs at different `epochs`: 500, 1350 and 5000.
* Create a second set of Python file with without `matplotlib`
* Add notebook replacing all for-loops with `lapply` functions. There is no drastically change in speed.
* `inst/python/gan` contains Python code that will be imported from R.
* Submodule `gan.rtorch`
* Add observations and measurements
* Test GAN from Rmarkdown
* Test GAN with `PyCharm`. Add folder
* Test GAN with `Jupyter`
* Add function `fivenum`

## 0.0.1 (2019-09-02)
* Add seed to numpy and PyTorch
