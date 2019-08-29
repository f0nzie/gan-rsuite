# - https://rosettacode.org/wiki/Fivenum#Python

from __future__ import division
import math
import sys
import numpy as np
 
def fivenum(array):
    if isinstance(array, np.ndarray): array = array.tolist()
    n = len(array)
    if n == 0:
        print("you entered an empty array.")
        sys.exit()
    x = sorted(array)
 
    n4 = math.floor((n+3.0)/2.0)/2.0
    d = [1, n4, (n+1)/2, n+1-n4, n]
    sum_array = []
 
    for e in range(5):
        floor = int(math.floor(d[e] - 1))
        ceil = int(math.ceil(d[e] - 1))
        sum_array.append(0.5 * (x[floor] + x[ceil]))
 
    return [round(elem, 8) for elem in sum_array] # round to 9 decimals
