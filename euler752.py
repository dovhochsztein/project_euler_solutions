from math import sqrt
from time import time

def mult(a1, b1, a2, b2, m):
    # (a1 + b1 * sqrt(7)) * (a2 + b2 * sqrt(7)) = a1*a2 + 7*b1*b2 + sqrt(7) * (a1*b2 + a2*b1)
    return (a1*a2 + 7*b1*b2) % m, (a1*b2 + a2*b1) % m


def alpha_beta(n, m):
    a = 1
    b = 1
    for ii in range(n-1):
        a, b = mult(a, b, 1, 1, m)
    return a, b


def alpha_beta_2(n, m, memory=None):
    if memory is None:
        memory = dict()
    if n in memory:
        return memory[n], memory
    if n == 1:
        solution = (1, 1)
        memory[n] = solution
        return solution, memory
    prev, memory = alpha_beta_2(n-1, m, memory)
    solution = mult(prev[0], prev[1], 1, 1, m)
    memory[n] = solution
    return solution, memory


class AlphaBeta:
    def __init__(self, m):
        self.memory = dict()
        self.m = m

    def alpha_beta(self, n):
        result, self.memory = alpha_beta_2(n, self.m)
        return result



for ii in range(1, 15):
    start_time = time()
    result_1 = alpha_beta(ii, 5)
    print(time() - start_time, result_1)
    start_time = time()
    result_2,_ = alpha_beta_2(ii, 5)
    print(time() - start_time, result_2)

def g(n):
    for ii in range(1, n**2+1):
        if alpha_beta(ii, n) == (1, 0):
            return ii
    else:
        return 0


def g_2(n):
    alpha_beta_obj = AlphaBeta(n)
    for ii in range(1, n**2+1):
        result = alpha_beta_obj.alpha_beta(ii)
        if result == (1, 0):
            return ii
    else:
        return 0


def G(N):
    total = 0
    for n in range(2, N-1):
        total += g(n)
    return total


for ii in range(2, 40):
    start_time = time()
    result_1 = g(ii)
    print(time() - start_time, result_1)
    start_time = time()
    result_2 = g_2(ii)
    print(time() - start_time, result_2)

start_time = time()
print(G(100), time() - start_time)