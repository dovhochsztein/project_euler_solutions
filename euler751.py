import math
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import fsolve
from decimal import Decimal, getcontext
theta = 2.9569

getcontext().prec=40
def tau(theta, num_values):
    b = [theta]
    a = [math.floor(theta)]
    for ii in range(num_values):
        b.append(math.floor(b[-1]) * (b[-1] - math.floor(b[-1]) + 1))
        a.append(math.floor(b[-1]))
    dec = a[0] + Decimal('0.' + ''.join(str(ii) for ii in a[1:]))
    return dec


thetas = np.linspace(2, 3, 1001)
thetas = [Decimal(ii) for ii in thetas]
taus = [tau(ii, 20) for ii in thetas]


plt.figure()
plt.plot(thetas, taus)
plt.plot(np.linspace(2, 3, 11), np.linspace(2, 3, 11))

# fsolve(lambda x: tau(x, 20) - x, x0=[Decimal(2.2235)], xtol=Decimal(1e-24))
# fsolve(lambda x: tau(x, 20) - x, x0=[2.2235], xtol=1e-24)


def bisection_search(func, x, lo=Decimal(0), hi=Decimal(np.inf), prec=Decimal(1e-8)):

    # Note, the comparison uses "<" to match the
    # __lt__() logic in list.sort() and in heapq.
    while hi - lo > prec:
        mid = (lo + hi) / 2
        if func(mid) > x:
            hi = mid
        else:
            lo = mid

    return lo

bisection_search(lambda x: x**2, Decimal(5), Decimal(2), Decimal(3), prec=Decimal(1e-8))
bisection_search(lambda x: x - tau(x, 20), Decimal(0), Decimal(2.2), Decimal(2.3), prec=Decimal(1e-8))
sol = bisection_search(lambda x: x - tau(x, 20), Decimal(0), Decimal(2.2), Decimal(2.3), prec=Decimal(1e-25))
