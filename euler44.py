from math import sqrt
import numpy as np
from time import time


def is_pent(n):
    val = (1+sqrt(1+24*n))/6
    return val % 1 == 0


def nth_pent(n, cache=None):
    if cache is None:
        cache=dict()
    if n not in cache:
        cache[n] = int(n*(3*n-1)/2)
    return cache[n], cache


def nth_pent_no_cache(n):
    return int(n*(3*n-1)/2)


# cache = dict()
# for ii in range(1, 50000):
#     start = time()
#     result, cache = nth_pent(ii, cache)
#     print(time() - start)
#     start = time()
#     result = nth_pent_no_cache(ii)
#     print(time() - start)
#     print(ii, result)
#
# for ii in range(50):
#     print(f'{ii} is {"not" if not is_pent(ii) else ""} pentagonal')
#
# P = [nth_pent(ii) for ii in range(35)]
# diffs = np.subtract.outer(P, P)
#
# pent_cache = dict()


def index_of_diff(n):
    return n//3


def find_sum(lim):
    pent_cache = dict()
    printed_diff = 1
    for diff_ind in range(1, lim):
        diff, pent_cache = nth_pent(diff_ind, pent_cache)
        max_index = index_of_diff(diff)
        for ind in range(1, max_index):
            first_pent, pent_cache = nth_pent(ind, pent_cache)
            second_pent = first_pent + diff
            if is_pent(second_pent):
                sum_pents = first_pent + second_pent
                if diff / printed_diff > 1.5:
                    print(diff, first_pent, second_pent, sum_pents)
                    printed_diff = diff
                if is_pent(sum_pents):
                    print(f'found! diff: {diff}; vals: {first_pent, second_pent} sum: {sum_pents}')
                    return diff
    else:
        return None
start = time()
find_sum(20000)
print(time() - start)

# diffs_set = set([ii for ii in diffs.flatten() if ii > 0])