import itertools

def is_cube(n):
    return int(round(n**(1/3))) ** 3 == n


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
        yield tuple()
    elif len(partition) == 1:
        yield tuple(remaining_positions)
    else:
        # print(partition)
        for combination in itertools.combinations(remaining_positions, partition[0]):
            new_remaining_positions = remaining_positions - set(combination)
            # print(combination, new_remaining_positions)
            gen = gen_positions_recursion(new_remaining_positions, partition[1:])
            for solution in gen:
                # print(combination + solution)
                yield (combination,) + solution


def gen_positions(partition, num_digits):
    positions = set(range(num_digits))
    remaining_positions = positions
    for part in partition:
        for combination in itertools.combinations(positions, part):
            print(combination)



def gen_digits(num_digits):
    partition_gen = gen_partitions(num_digits)
    for partition in partition_gen:
        print(partition)
        for digits in itertools.permutations(range(10), len(partition)):
            positions_gen = gen_positions_recursion(set(range(num_digits)), partition)
            for position in positions_gen:
                number = [0] * num_digits
                for places, digit in zip(position, digits):
                    for place in places:
                        number[place] = digit
            # digits_dict = {value: number for value, number in zip(position, partition)}

            # yield digits_dict


def gen_permutations(digits_dict, num_digits):
    number = [0] * 3
    frequencies = 1
    for key, value in digits_dict.items():
        pass




n_digits = 8
