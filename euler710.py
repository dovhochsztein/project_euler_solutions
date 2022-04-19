from time import time
import sys

sys.setrecursionlimit(1000000)

def num_tupals(n, cache=None, mod=None):
    """
    number palindromic sums
    """
    if cache is None:
        cache = dict()
    if n in cache:
        return cache[n], cache
    if n == 0:
        sol = 1
        cache[n] = sol
        return sol, cache
    if n == 2:
        sol = 2
        cache[n] = sol
        return sol, cache
    total = 1  # include tuple of just the number
    for ii in range(int(n/2)):
        first_last = ii + 1
        prev, cache = num_tupals(n - first_last * 2, cache, mod=mod)
        total += prev
    if mod is not None:
        total = total % mod
    cache[n] = total
    return total, cache


a, cache = num_tupals(20)


def num_twopals(n, cache=None, tupals_cache=None, mod=None):

    """
    number palindromic sums with 2
    """
    if cache is None:
        cache = dict()
    if tupals_cache is None:
        tupals_cache = dict()
    if n in cache:
        return cache[n], cache
    if n == 0:
        sol = 0
        cache[n] = sol
        return sol, cache
    if n == 2:
        sol = 1
        cache[n] = sol
        return sol, cache
    if n == 4:
        sol = 2
        cache[n] = sol
        return sol, cache
    total = 0
    for ii in range(int(n / 2)):
        first_last = ii + 1
        if first_last == 2:
            prev, tupals_cache = num_tupals(n - first_last * 2, tupals_cache, mod=mod)
        else:
            prev, cache = num_twopals(n - first_last * 2, cache, mod=mod)
        total += prev
    if mod is not None:
        total = total % mod
    cache[n] = total
    return total, cache

start = time()
N=1000
a, cache = num_twopals(N, mod=1000000)
print(f'time: {time() - start}')
cache_list = [cache[ii] for ii in range(0, N+1, 2)]

cache = dict()
mod = 1000000
for ii in range(2, 1000000, 2):

    a, cache = num_twopals(ii, cache, mod=mod)
    if not a % mod:
        print(ii)
        break
