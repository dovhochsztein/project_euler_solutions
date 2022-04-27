from primes_utility import calculate_prime_factors, all_factors
import math
import numpy as np
from time import time





def g(n):
    if n == 1:
        return 1
    factors = calculate_prime_factors(n)
    max_square = 1
    for factor, multiplicity in factors.items():
        max_square *= factor ** (multiplicity - (multiplicity % 2))
    return max_square

def S(N):
    total = 0
    for ii in range(1, N+1):
        total += g(ii)
    return total

start = time()
S(100)
print(time() - start)


def S_2(N, mod=None):
    num_squares = int(math.sqrt(N))
    multiples_of_n_squares = np.zeros(num_squares).astype(int)
    squares = np.zeros(num_squares).astype(int)
    for index in reversed(range(num_squares)):
        root = index + 1
        # prime_factors = calculate_prime_factors(root)
        factors = all_factors(root, include_one=False, include_itself=False)
        squares[index] = root**2
        number_of_multiples = (multiples_of_n_squares[index] + int(N / root**2))
        if mod:
            number_of_multiples = number_of_multiples % mod
        multiples_of_n_squares[index] = number_of_multiples
        if root > 1:
            multiples_of_n_squares[0] -= number_of_multiples
        # for factor, multiplicity in factors.items():
        #     for exponent in range(1, multiplicity + 1):
        #         val = factor ** exponent
        #         if val != root:
        #             multiples_of_n_squares[val - 1] -= number_of_multiples
        for factor in factors:
            multiples_of_n_squares[factor - 1] -= number_of_multiples
    solution = np.dot(squares, multiples_of_n_squares)
    if mod:
        solution = solution % mod
    return solution

N=144
num_squares = int(math.sqrt(N))
multiples_of_n_squares_known = np.zeros(num_squares)
for ii in range(1, N+1):
    multiples_of_n_squares_known[int(math.sqrt(g(ii))) - 1] += 1

times_1 = list()
times_2 = list()
tests = [10, 100, 1000, 10000, 100000, 1000000, int(1e7), int(1e8)]
mod = 1000000007
for ii in tests:
    # start = time()
    # method_1 = S(ii)
    # times_1.append((time() - start))
    start = time()
    method_2 = S_2(ii, mod=mod)
    times_2.append((time() - start))
    # if method_1 != method_2:
    #     print(f'failed: {ii}')
    #     break

N = int(1e8)
mod = 1000000007

start = time()
plain = S_2(N)
print(time() - start)
start = time()
modded = S_2(N, mod=mod)
print(time() - start)
print((plain % mod) == modded)




N = 10**14
average_time_increment = np.mean(np.divide(times_2[1:], times_2[:-1]))
expected_time = times_2[-1] * average_time_increment ** np.log10(N / tests[-1])
print(f'expected time: {round(expected_time)} seconds')
print(S_2(10**14))