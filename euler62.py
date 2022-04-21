import itertools
from math import log10
import time

set_7 = {0, 1, 6}
set_9 = {0, 1, 8}
set_13 = {1, 8, 12, 5, 0}
set_19 = {1, 8, 7, 11, 18, 12, 0}
set_31 = {1,8,27,2,30,16,29,23,4,15,0}
set_37 = {1,8,27,14,31,10,26,36,6,29,23,11,0}
digital_sum_set = {0, 1, 8, 9}

def is_cube(n):
    if n % 7 not in set_7:
        return False
    if n % 9 not in set_9:
        return False
    if n % 13 not in set_13:
        return False
    if n % 19 not in set_19:
        return False
    if n % 31 not in set_31:
        return False
    if n % 37 not in set_37:
        return False
    return int(round(n**(1/3))) ** 3 == n


start = time.time()
N = 10**7
for ii in range(1, N):
    is_cube(ii)
print(f'average time: {(time.time() - start)/N}')


def unique_permutations(group):
    permutation_set = set()
    for permutation in itertools.permutations(group, len(group)):
        if permutation not in permutation_set:
            permutation_set.add(permutation)
    return list(permutation_set)


def gen_partitions(number):
    p = [0] * number  # An array to store a partition
    k = 0  # Index of last element in a partition
    p[k] = number  # Initialize first partition
    # as number itself

    # This loop first prints current partition,
    # then generates next partition.The loop
    # stops when the current partition has all 1s
    while True:

        # print current partition
        yield (p[:k + 1])

        # Generate next partition

        # Find the rightmost non-one value in p[].
        # Also, update the rem_val so that we know
        # how much value can be accommodated
        rem_val = 0
        while k >= 0 and p[k] == 1:
            rem_val += p[k]
            k -= 1

        # if k < 0, all the values are 1 so
        # there are no more partitions
        if k < 0:
            print()
            return

        # Decrease the p[k] found above
        # and adjust the rem_val
        p[k] -= 1
        rem_val += 1

        # If rem_val is more, then the sorted
        # order is violated. Divide rem_val in
        # different values of size p[k] and copy
        # these values at different positions after p[k]
        while rem_val > p[k]:
            p[k + 1] = p[k]
            rem_val = rem_val - p[k]
            k += 1

        # Copy rem_val to next position
        # and increment position
        p[k + 1] = rem_val
        k += 1


def gen_positions_recursion(remaining_positions, partition):
    if len(partition) == 0:
        yield (tuple(),)
    elif len(partition) == 1:
        yield (tuple(remaining_positions),)
    else:
        # print(partition)
        for combination in itertools.combinations(remaining_positions, partition[0]):
            # print(combination)
            new_remaining_positions = remaining_positions - set(combination)
            # print(combination, new_remaining_positions)
            gen = gen_positions_recursion(new_remaining_positions, partition[1:])
            for solution in gen:
                # print(combination, solution)
                yield (combination,) + solution


def iter_families(num_digits, number_cubes):
    families = list()
    partition_gen = gen_partitions(num_digits)
    for partition in partition_gen:
        # print(partition)
        for ordered_partition in unique_permutations(partition):

            for digits in itertools.combinations(range(10), len(ordered_partition)):
                # print(digits)
                positions_gen = gen_positions_recursion(set(range(num_digits)), ordered_partition)
                # below is a family
                family = []
                for position in positions_gen:
                    number = [0] * num_digits
                    for places, digit in zip(position, digits):
                        for place in places:
                            number[place] = digit
                    if number[0] == 0:
                        continue
                    decimal = sum([10**ii * number for number, ii in zip(number, reversed(range(num_digits)))])
                    if is_cube(decimal):
                        family.append(decimal)
                        if len(family) > number_cubes:
                            break
                if len(family) == number_cubes:
                    families.append(min(family))
    return families


def digital_sum(number):
    if number < 10:
        return number
    else:
        digits = [int(ii) for ii in str(number)]
        return digital_sum(sum(digits))

# reverse engineer

def get_partition_and_digits_from_number(number):
    digits = [int(ii) for ii in str(number)]
    # digits = [number // 10**ii for ii in reversed(range(int(log10(number) + 1)))]
    freqs = dict()
    for digit in digits:
        if digit in freqs:
            freqs[digit] += 1
        else:
            freqs[digit] = 1
    unique_digits = list()
    ordered_parition = list()
    for digit, freq in freqs.items():
        unique_digits.append(digit)
        ordered_parition.append(freq)
    return unique_digits, ordered_parition


def iter_families_2(num_digits, number_cubes):
    families = list()
    found_values = set()
    min_root = int((10**(num_digits-1)) ** (1/3))
    max_root = int((10**(num_digits)) ** (1/3))
    for cube_root in range(min_root, max_root+1):
        cube = cube_root ** 3
        # if len(str(cube)) != num_digits:
        if int(log10(cube)) + 1 != num_digits:
            continue
        if cube in found_values:
            continue
        digits, ordered_partition = get_partition_and_digits_from_number(cube)
        positions_gen = gen_positions_recursion(set(range(num_digits)),
                                                ordered_partition)
        # below is a family
        family = []
        for position in positions_gen:
            number = [0] * num_digits
            for places, digit in zip(position, digits):
                for place in places:
                    number[place] = digit
            if number[0] == 0:
                continue
            decimal = sum([10 ** ii * number for number, ii in
                           zip(number, reversed(range(num_digits)))])
            if is_cube(decimal):
                family.append(decimal)
                if len(family) > number_cubes:
                    break
        if len(family) == number_cubes:
            families.append(min(family))
            for element in family:
                found_values.add(element)
            break
    return families

# num_digits = 8
# number_cubes = 3
# families = iter_families(num_digits, number_cubes)
# print(min(families))
# families = iter_families_2(num_digits, number_cubes)
# print(min(families))

max_digits = 10
def search(max_digits, number_cubes):
    start = time.time()
    for num_digits in range(1, max_digits):
        print(f'searching {num_digits} digit numbers {time.time() - start} seconds in')
        families = iter_families_2(num_digits, number_cubes)
        if len(families) > 0:
            break
    return min(families)

start = time.time()
print(search(10, 3))
print(time.time() - start)
# print(search(10, 4))
start = time.time()
print(search(20, 5))
print(time.time() - start)
