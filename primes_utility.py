import itertools
import numpy as np

def calculate_prime_factors(N):
    prime_factors = dict()
    if N < 2:
        return prime_factors
    if N % 2 == 0:
        prime_factors[2] = 0
    while N % 2 == 0:
        prime_factors[2] += 1
        N = N // 2
        if N == 1:
            return prime_factors
    for factor in range(3, N + 1, 2):
        if N % factor == 0:
            if factor in prime_factors:
                prime_factors[factor] += 1
            else:
                prime_factors[factor] = 0
            while N % factor == 0:
                prime_factors[factor] += 1
                N = N // factor
                if N == 1:
                    return prime_factors


def all_factors(N, include_one=False, include_itself=False):
    prime_factorization = calculate_prime_factors(N)

    if prime_factorization is None:
        return list()

    prime_factors = list(prime_factorization.keys())
    multiplicities = list(prime_factorization.values())

    factors = list()
    for comb in itertools.product(*[range(multiplicity + 1) for multiplicity in multiplicities]):
        new_factor = np.prod([factor ** exponent for factor, exponent in zip(prime_factors, comb)])
        if (include_one or new_factor != 1) and (include_itself or new_factor != N):
            factors.append(new_factor)
    return factors