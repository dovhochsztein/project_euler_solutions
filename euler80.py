from time import time
from math import sqrt, log10, floor
from decimal import Decimal, getcontext

getcontext().prec=120
def digit_sqrt(n):
    num_digits = floor(log10(n)) + 1
    digits = 1


# function: x**2 - 2 = 0
# deriv: 2x
n = Decimal(2)
guess = Decimal(sqrt(2))
def newton_method(n, guess, tol=Decimal(1e-110)):
    n = Decimal(n)
    guess = Decimal(guess)
    while abs(guess ** 2 - n) > tol:
        guess = guess - (guess**2 - n) / (2 * guess)
        # print(abs(guess ** 2 - n))
    return guess

total = 0
for ii in range(1, 101):
    if int(sqrt(ii)) ** 2 == ii:
        continue
    sqrt_100 = newton_method(ii, sqrt(ii))
    string = str(sqrt_100)
    new = int(string[0]) + sum([int(ii) for ii in string[2:101]])
    print(ii, new)
    total += int(string[0]) + sum([int(ii) for ii in string[2:101]])



