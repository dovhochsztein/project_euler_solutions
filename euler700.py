import math
from collections import OrderedDict
import bisect
import time
x = 1504170715041707
m = 4503599627370517


def sum_coins(n):
    solution = 0

    val = 0
    found = 0
    mincoin = 1e30
    while True:
        if found == n:
            break
        val = (val + x) % m
        if val == 0:
            break
        if val < mincoin:
            solution += val
            mincoin = val
            found += 1
            # print(mincoin)
            # print(solution)
    return solution


def sum_coins_2(n):
    solution = x

    val = x
    mincoin = x
    number_moves = [1]
    deduction = [m - val]
    found = 1
    counter = 1
    while True:
        if found == n:
            break
        if val == 0:
            break
        # if len(number_moves) == 0:
        #     val = (val + x) % m
        #     if val < mincoin:
        #         solution += val
        #         mincoin = val
        #         found += 1
        #     index = 0
        #     counter += 1
        if deduction[0] > mincoin:
            val = (val + x) % m
            counter += 1
        else:
            print('yay')
            index = bisect.bisect(deduction, val)
            val = val - deduction[index - 1]
            counter += number_moves[index - 1]

        if val < mincoin:
            solution += val
            mincoin = val
            found += 1

        index = bisect.bisect(deduction, m - val)
        deduction.insert(index, m - val)
        number_moves.insert(index, counter)
        # print(solution)

    return solution



[sum_coins_2(n) == sum_coins(n) for n in range(2,10)]

start = time.time()
sum_coins_2(11)
print(time.time() - start)
start = time.time()
sum_coins(11)
print(time.time() - start)


print(sum_coins(17))