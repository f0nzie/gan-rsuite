# gan-rsuite

The original number of epochs is `5,000`.
Originally there is no seed to "control"" the randomness.


## Observations
* The maximum number of iterations tried is `10`; the minimum in `1`.
Each iteration produces a new distribution sample.

* We can say that definitely is not a good idea to go through epochs lower than 1000 because they start presenting bimodalism. A minimum acceptable number of epochs seems to be 1250-1350.




* There is an impact on the speed ofr the train() loop when the algorithm is transported to R. At leats, the train loop takes 10 times as much as the loop in the native Python.

