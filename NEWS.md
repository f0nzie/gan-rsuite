# CHANGES

## 0.0.7 (2019-09-14)

* add new example for Wasserstein GAN from [repo](https://github.com/martinarjovsky/WassersteinGAN) based on [paper Wasserstein GAN](https://arxiv.org/abs/1701.07875). Modify code to make it able running from CPU.

## 0.0.6.9001 (2019-09-13)

* add documentation for each project via `README.md`


## 0.0.6.9000 (2019-09-13)
* Regenerate `.rda` files for seed=123 and 500, 5000 epochs

## 0.0.6 (2019-09-13)
* WGANs running. Based on MNIST digits. Stopped at 40,000 iterations
* Vanilla GAN running
* Using symbolic link to `utils.py` in PyCharm folder
* Output file not included either
* Not including data files (they can be downloaded)
* Documenting changes from Python 2.7 to 3.x on `mnist-wgan-gp` project
* New GANs as Jupyter and Rmarkdown notebooks
* Added `PyCharm` projects folder
* Folders `univariate` and `multivariate` GANs

## 0.0.5 (2019-09-09)
* Generate synthetic data at seed=456 and 777
* Slides with synthetic data at seeds 123, 456 and 777
* Make function for converting lists of dataframes to unique dataframes
* New notebook series 6 to read synthetic data files

## 0.0.4.9001 (2019-09-08)
* Write .rda file of synthetic datasets (ten) and metrics
* Summarize mean and sd for all the synthetic samples
* Plot histograms for all the synthetic datasets (ten)

## 0.0.4.9000 (2019-09-08)
* Write CSV real data file

## 0.0.4 (2019-09-08)
* Corresponding Rmarkdown notebooks for calling the Python scripts.
* New script `gan_noplot_params)metrics.py` that return the metrics and the synthetic data from each of the samples.
* New script `gan_noplot_params_df.py` that returns a dataframe of only the statistical metrics from the GAN.
* New README as Rmd file


## 0.0.3 (2019-09-06)
* Add new script `gan_noplot_params.py` that receives a parameter for the number of epochs.
* New notebook series 4 to study the distributions for real and fake data
* Print the mean and standard deviation at the end of each sample (10 samples)
* Take more measurements of `fivenum` of the resulting distribution
* Plot histograms of the real and fake data

## 0.0.2 (2019-09-06)
* Use Python code without matplotlib for comparative results: Rmarkdown vs Jupyter vs PyCharm.
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
