# length is long diagonal of parallelogram:

# https://www.cuemath.com/diagonal-of-parallelogram-formula/
# q = sqrt(x^2 + y^2 + 2xycosA) = sqrt(x^2 + y^2 + xy) (A is 60 degrees)
# in units of sqrt(3), q = sqrt(3) * sqrt(x^2 + y^2 + xy)
# where x, y, integers are the distances in number of honeycombs
# for for x,y = 1,2 honeycombs, the distance is sqrt(3) * sqrt(4+1+2)
# = sqrt(21)

# work backwards:
# for s=sqrt(21) we need integers x,y solving x^2 + y^2 + xy = 7

import math


def L(x, y):
    return x**2 + y**2 + x*y


def calculate_prime_factors(N):
    prime_factors = dict()
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

N = 37037037

N = 7
# use N where it is divided by N**/3


def prod(prime_factors):
    """
    https://math.stackexchange.com/questions/44139/how-many-solutions-are-there-to-fn-m-n2nmm2-q
    """
    b = 1
    for factor, exponent in prime_factors.items():
        if factor % 3 == 2:
            if exponent % 2:
                return 0
        elif factor % 3 == 1:
            b *= (exponent + 1)
    return b


def B_sqrt(N):
    """
    Use when the value is written as sqrt(3) * sqrt(N)
    """
    if N == 1:
        return 6
    prime_factors = calculate_prime_factors(N)
    b = prod(prime_factors)
    return b * 6


N = 111111111

def B_whole_number_odd_mult_3(N):
    prime_factors = calculate_prime_factors(N)
    new_prime_factors = {key: (2 * value - (key == 3)) for key, value in
                         prime_factors.items()}
    b = prod(new_prime_factors)
    return b * 6


def B_even_mult_4(N):
    return 6


B = 12
lim = int(5e5)
lim = 10


def num_given_B(lim, B):
    total = 0
    for ii in range(3, lim, 6):
        gotten_B = B_whole_number_odd_mult_3(ii)
        if gotten_B == B:
            print(ii)
            total += 1
    for ii in range(1, int(lim**2 / 3)):
        gotten_B = B_sqrt(ii)
        if gotten_B == B:
            print(f'sqrt({3 * ii}) = {math.sqrt(3 * ii)}')
            total += 1
    for ii in range(4, lim, 4):
        gotten_B = B_even_mult_4(N)
        if gotten_B == B:
            print(ii)
            total += 1
    return total

# todo num given B shorter version using factorization from above


def alphas(prime_factors):
    return {key - 1: value for key, value in prime_factors.items()}


def num_given_B_2(lim, B):
    B_prime_factorization = calculate_prime_factors(B)