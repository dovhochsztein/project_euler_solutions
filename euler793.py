import numpy as np
from time import time

from heapq import heappush, heappop, heapify
import math

def seq_n(n):
    S = [290797]
    for ii in range(n - 1):
        S.append(S[-1]**2 % 50515093)
    return S


def brute_force(N):
    S = seq_n(N)
    S.sort()
    S = np.array([S])
    mat = np.dot(S.T, S)
    return np.median([mat[ii, jj] for ii in range(N) for jj in range(ii)])



# figure out how to ignore the smallest/biggest ones
# ii < jj
# (N ** 2 - N) / 2 values
# for a given value ii, jj, it is bigger than the trapezoid above it, less than
# the one below it:
# ii, jj  = 3, 1
#        [1., 1., 1., 1., 1.]
#        [1., 1., 1., 1., 1.]
#        [1., 1., 1., 1., 1.]
#        [1., 2., 1., 1., 1.]
#        [1., 1., 1., 1., 1.]
# this trapezoid is <= the value:
#        [1., 1., 1., 1., 1.]
#        [0., 1., 1., 1., 1.]
#        [0., 0., 1., 1., 1.]
#        [0., 0., 1., 1., 1.]
#        [1., 1., 1., 1., 1.]
# width -> jj + 1
# higher height -> ii
# lower height -> ii - jj
# trapezoid has area: (jj + 1)(ii + ii - jj) / 2
# cutoff value itself -> (jj + 1)(2 * ii - jj) / 2 - 1
# 4 values
# trapezoid below has all values below
#        [1., 1., 1., 1., 1.]
#        [1., 1., 1., 1., 1.]
#        [1., 1., 1., 1., 1.]
#        [1., 0., 0., 1., 1.]
#        [1., 0., 0., 0., 1.]

# width -> N - ii
# higher height -> N - jj - 1
# lower height -> N - jj - 1 (N - ii - 1) = ii - jj
# trapezoid has area: (N - ii)(N - jj - 1 + ii - jj) / 2
# cutoff value itself -> (N - ii)(N - 2 * jj + ii - 1) / 2 - 1
# 4 values

N = 1003
check = np.zeros((N, N))
check_2 = np.zeros((N, N))
triangle_size = int((N ** 2 - N) / 2)
critical_number_values = int((triangle_size + 1) / 2)
skips = 0
for ii in range(N):
    for jj in range(N):
        # check[ii, jj] = (jj + 1) * (2 * ii - jj) / 2 - 1
        # check_2[ii, jj] =(N - ii) * (N - 2 * jj + ii - 1) / 2 - 1
        if (jj + 1) * (2 * ii - jj) / 2 - 1 > critical_number_values or \
            (N - ii) * (N - 2 * jj + ii - 1) / 2 - 1 > critical_number_values:
            check[ii, jj] = 0
        else:
            check[ii, jj] = 1
            skips += 1

import sympy
ii = sympy.core.Symbol('ii')
jj = sympy.core.Symbol('jj')
N = sympy.core.Symbol('N')
crit = sympy.core.Symbol('crit')
expr = (jj + 1) * (2 * ii - jj) / 2 - 1 - crit
eq = sympy.Eq((jj + 1) * (2 * ii - jj) / 2 - 1, crit)
desc = sympy.Eq(-8*crit + 4*ii**2 + 4*ii - 7, 0)
eq_2 = sympy.Eq((N - ii) * (N - 2 * jj + ii - 1) / 2 - 1, crit)
sympy.solve(expr, jj)
sympy.solve(eq, jj)
sympy.solve(eq_2, jj)
sympy.solve(desc, ii)

N = 1003
triangle_size = int((N ** 2 - N) / 2)
critical_number_values = int((triangle_size + 1) / 2)
# jj_funx = lambda ii, crit: crit - (ii + np.sqrt(4*ii**2 + 4*ii - 7)/2 - 1/2)
jj_funx = lambda ii, crit, N: ii - np.sqrt(-8*crit + 4*ii**2 + 4*ii - 7)/2 - 1/2
jj_funx_2 = lambda ii, crit, N: (N**2 - N - 2*crit - ii**2 + ii - 2)/(2*(N - ii))
jj_funx(750, critical_number_values, N)
jj_funx_2(100, critical_number_values, N)
desc_funx = lambda crit: np.sqrt(2*crit + 2) - 1/2


def index_gen(N):
    triangle_size = int((N ** 2 - N) / 2)
    critical_number_values = int((triangle_size + 1) / 2)
    for ii in range(N):
        for jj in range(ii):
            if not ((jj + 1) * (2 * ii - jj) / 2 - 1 > critical_number_values or \
            (N - ii) * (N - 2 * jj + ii - 1) / 2 - 1 > critical_number_values):
                yield ii, jj


def index_gen_2(N):
    triangle_size = int((N ** 2 - N) / 2)
    critical_number_values = int((triangle_size + 1) / 2)
    descriminant = desc_funx(critical_number_values)
    for ii in range(N):
        if ii > descriminant:
            max_jj = int(min(jj_funx(ii, critical_number_values, N), ii))
        else:
            max_jj = ii - 1
        min_jj = int(max(jj_funx_2(ii, critical_number_values, N) - 1e-10 + 1, 0))
        for jj in range(min_jj, max_jj + 1):
            yield ii, jj


def get_median(N):
    print(f'N: {N}')
    S = seq_n(N)
    print('sequence_generated')
    S.sort()
    print(f'sorted')
    med = int(np.median([S[ii] * S[jj] for (ii, jj) in index_gen_2(N)]))
    return med

def get_median_2(N):
    minHeap = []
    heapify(minHeap)
    maxHeap = []
    heapify(maxHeap)

    def insertHeaps(num):
        heappush(maxHeap,
                 -num)  ### Pushing negative element to obtain a minHeap for
        heappush(minHeap, -heappop(maxHeap))  ### the negative counterpart

        if len(minHeap) > len(maxHeap):
            heappush(maxHeap, -heappop(minHeap))

    def get_median_heaps():
        if len(minHeap) != len(maxHeap):
            return -maxHeap[0]
        else:
            return (minHeap[0] - maxHeap[0]) / 2
    S = seq_n(N)
    S.sort()
    for (ii, jj) in index_gen_2(N):
        insertHeaps(S[ii] * S[jj])
    med = get_median_heaps()
    return med

N = 1003
check = np.zeros((N, N))
gen = index_gen(N)
for index in gen:
    check[index[0], index[1]] = 1
N = 1003
check_2 = np.zeros((N, N))
gen = index_gen_2(N)
for index in gen:
    check_2[index[0], index[1]] = 1
print(np.all(check == check_2))


# ratios = list()
# for N in range(3, 1005, 2):
#
#     # start = time()
#     # med = brute_force(N)
#     # print(f'N: {N} time: {time() - start}; median: {med}')
#     start = time()
#     med = get_median(N)
#     run_time = time() - start
#     print(f'N: {N} time: {run_time}; median: {med}')
#     ratios.append(run_time / N**2)
    # start = time()
    # med = get_median_2(N)
    # print(f'N: {N} time: {time() - start}; median: {med}')
    #
    # check = np.zeros((N, N))
    # gen = index_gen(N)
    # for index in gen:
    #     check[index[0], index[1]] = 1
    # check_2 = np.zeros((N, N))
    # gen = index_gen_2(N)
    # for index in gen:
    #     check_2[index[0], index[1]] = 1
    # if not np.all(check == check_2):
    #     break

    # S = seq_n(N)
    # S.sort()
    # S_array = np.array([S])
    # mat = np.dot(S_array.T, S_array)
    # med = int(np.median([mat[ii, jj] for ii in range(N) for jj in range(ii)]))
    # med_2 = int(np.median([S[ii] * S[jj] for (ii, jj) in index_gen(N)]))
    # print(med_2 == med)
    # indices = np.where(mat == med)
    # index = indices[0][0], indices[0][1]
    # check = sum(index) == N - 1
    # print(N, index, check)



print(get_median(3))
print(get_median(103))
print(get_median(1003))
print(get_median(1000003))