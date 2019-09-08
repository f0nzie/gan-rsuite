
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gan-rsuite

<!-- badges: start -->

<!-- badges: end -->

# A Generative Adversarial Networks (GAN) in rTorch for creating synthetic datasets. Season 1 Episode 1

## Introduction

I recently finished double-converting, from Python to R, and from
PyTorch to rTorch, a very powerful script that creates synthetic
datasets from real datasets.

Synthetic datasets are based on real data but altered enough to keep the
privacy, confidentiality or anonymity, of the original data. Since
synthetic datasets conserve the original statistical characteristics of
the real data, this could represent a breakthrough in petroleum
engineering for sharing data, as the oil and gas industry is well known
for the secrecy of its data.

## Procedure

I will start by sharing the original code in Python+PyTorch, and
immediately below it, the R+rTorch converted code. I will also include
some plots of the distributions of the synthetic datasets, as well as
numeric results.

This is the link to GitHub repository where I have put the R and Python:
<https://github.com/f0nzie/gan-rsuite>. It consists mainly of Rmarkdown
notebooks, a few Jupyter notebooks, a handful of Python scripts with
PyTorch, and few other R scripts. The Rmarkdown notebooks explain the
conversion and transition from PyTorch to rTorch. So, if you want to
learn PyTorch at the same you learn R, this is your chance.

The Rmarkdown notebooks have been numbered in such a way you could
follow the transition by the ascending number of the documents.

The plan is explaining a little bit how this algorithm works, the steps
to build one yourself in Python or R, show the original dataset, compare
it with the synthetic, make some observations from the data artificially
generated, and draw some conclusions about sharing synthetic datasets.

## GAN in PyTorch

I don’t expect the code to look beautiful here. If you don’t like how
the code looks here in LinkedIn, please, visit the repository to take a
look. This is the original code as was presented by its author Dev Nag
in Medium. I will use this code as a base because it works and is very
straight forward and short. The final code will have some minor
variations for the output of the GAN metrics and the synthetic data. The
code corresponding to this script can be found as “gan\_torch.py” under
the folder notebooks.

    <Python code>

The following plot is just one sample of the training at 5,000 epochs.
The more samples you get to iterate the better. Choose one of the
samples that approximates close to the original distribution of the data
source. We will run a loop for generating ten samples of synthetic data
and plot the distributions of all of them as well.

    <plot distribution matplotlib>

This is the output of each epoch showing some evaluation metrics of the
GAN. What we show are:

  - The errors in the Discriminator (D) for the real data and the fake
    data
  - The error in the Generator (G)
  - The mean and standard deviation for the real data
  - The mean and standard deviation for the synthetic data

## GAN in rTorch

The following code is the converted code from PyTorch to rTorch. They
will look essentially the same. It will be completely up to you if you
want to run the PyTorch code in its native Python, or the R version of
it. In my particular case I find myself more comfortable working with
the R data structures like dataframes, lists and vectors.

This code is almost a literal conversion of the Python code we just have
shown above. This code can be found as the file “gan\_torch.R” under the
folder notebooks.

    <R code>

This is is the output data from R.

    output

And this is the histogram in R. No fancy things here; just plain, simple
r-base. This is the result of running the training for 5,000 epochs.

    histogram in R

## Motivation

For the moment, I just wanted to share the preliminary results of the
converted code. Both versions, in Python and R, run fine. I have managed
to generate additional runs on the train() function to find out how the
fake data (synthetic) distribution behaves, or how different is from the
real data. My second objective is to show the differences in coding in
PyTorch vs rTorch. They are pretty similar with exception of the obvious
language differences and the way we pass parameters to the PyTorch
library. For instance, an integer has to be explicitly declared in R
when calling a PyTorch function (0L, 1L, 2L). Or, when you need to pass
a tuple for the shape of a tensor, you should use c() or list() in R.
But it mostly fun. Additionally, I wanted to test my rTorch package with
a real application such as this GAN.

## Findings

  - Each run of 5,000 epochs takes approximately 20 minutes, without a
    GPU.

  - You can try reducing the number of epochs in the training to, let’s
    say, 500. I invite you to do it and see the shape of the
    distribution for the synthetic data. It won’t be the same quality as
    the distribution at 5,000 epochs.

  - When I say quality, I mean how much the synthetic data resembles the
    real or original data. We use the mean and standard deviation as
    part of the evaluation metrics.

  - Plotting the synthetic data histogram is also a good guidance of how
    well it approximates to the real data.

## Code

The code has been published in GitHub (Python and R). I used R, RStudio,
Python Anaconda3 for 64-bits, and the R packages reticulate, rTorch,
rsuite, ggplot2. On the Python side, PyTorch, numpy, pandas, matplotlib.
I tried to avoid using matplotlib and use ggplot2 instead.

In the next episodes of these series, I will publish a real petroleum
engineering dataset converted to synthetic data, so you could feel the
difference. I was thinking on the Volve reservoir simulation data which
already has been published.

There are lots to be learned by comparing a synthetic dataset versus the
original dataset, starting with a simple Exploratory Data Analysis
(EDA). In the next episode

  - Plot of the real data distribution
  - Plots of 10 sets of synthetic data at 500 epochs and 5,000 epochs
  - How do we know we obtained a good set of synthetic data

## Repository

    GitHub: https://github.com/f0nzie/gan-rsuite

-----

## Characteristics

The original number of epochs is `5,000`. Originally there is no seed to
“control” the randomness in `numpy` or `PyTorch`

## Observations

  - The maximum number of iterations tried is `10`; the minimum in `1`.
    Each iteration produces a new distribution sample.

  - We can say that definitely is not a good idea to go through epochs
    lower than 1000 because they start presenting bimodalism. A minimum
    acceptable number of epochs seems to be 1250-1350.

  - There is an impact on the speed of the `train()` loop when the
    algorithm is transported to R. At leats, the train loop takes 10
    times as much as the loop in the native Python.

## Rmarkdown notebooks

## R and Python scripts

  - `notebooks/gan_torch_apply.R`: Script in R that replaces for loops
    with `lapply` functions.

  - `notebooks/gan_noplot.py`: Script in Python without `matplotlib`.

  - `notebooks/gan_torch.py`: Original script in Python with plotting
    capability.

  - `notebooks/gan_torch.R`: Original GAN script converted from Python
    to R. It uses for loops.

  - `notebooks/py_function.py`: Script holder for miscelaneous Python
    functions such as `fivenum`.

## Jupyter notebooks

  - `notebooks/test GAN with no-plot.ipynb`: GAN script without
    matplotlib.

  - `notebooks/test GAN with with plot.ipynb`: GAN script with
    matplotlib.

## Python imports in R

Under folder `inst/python` of package `gan.rtorch`.

-----

## References

  - Original article “Generative Adversarial Networks (GANs) in 50 lines
    of code (PyTorch)” by Dev Nag. This is the article that made get
    hooked in GANs.

  - Paper “Privacy and Synthetic Datasets”, by Steven M. Bellovin,
    Preetam K. Dutta, and Nathan Reitinger. 2019.

  - Article “An introduction to Generative Adversarial in TensorFlow” by
    John Glover. 2019. Paper “Generative Adversarial Nets” by
    Goodfellow, Pouget-Abadie, Mirza, Xu, Warde-Farley, Ozair, Courville
    and Bengio. 2014.

  - Paper “Improved Techniques for Training GANs”, by Tim Salimans, Ian
    Goodfellow, Wojciech Zaremba, Alec Radford, Vicki Cheung, Xi Chen.
    2016.

  - Article “Artificial data give the same results as real data —
    without compromising privacy” by Stefanie Koperniak. 2017.

  - Article “Synthetic data, privacy, and the law” by Brad Wible.
    Science 2019.
