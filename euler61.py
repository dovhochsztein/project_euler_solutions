from math import log10
import bisect

oct_formula = lambda n: n * (3*n - 2)
hept_formula = lambda n: int(n * (5*n - 3) / 2)
hex_formula = lambda n: n * (2*n - 1)
pent_formula = lambda n: int(n * (3*n - 1) / 2)
sqr_formula = lambda n: n ** 2
tri_formula = lambda n: int(n * (n + 1) / 2)


def gen_values(funx, lower, upper):
    values = list()
    value = 0
    n = 1
    while value < upper:
        if value >= lower:
            values.append(value)
        value = funx(n)
        n += 1
    return values

octagonal = gen_values(oct_formula, 1e3, 1e4)
heptagonal = gen_values(hept_formula, 1e3, 1e4)
hexagonal = gen_values(hex_formula, 1e3, 1e4)
pentagonal = gen_values(pent_formula, 1e3, 1e4)
square = gen_values(sqr_formula, 1e3, 1e4)
triangular = gen_values(tri_formula, 1e3, 1e4)

oct_set = set(octagonal)
hept_set = set(heptagonal)
hex_set = set(hexagonal)
pent_set = set(pentagonal)
sqr_set = set(square)
tri_set = set(triangular)

polygon_dict = {8: (octagonal, oct_set),
                7: (heptagonal, hept_set),
                6: (hexagonal, hex_set),
                5: (pentagonal, pent_set),
                4: (square, sqr_set),
                3: (triangular, tri_set),
                }

def sub_dict(dictionary, keys):
    return {key: dictionary[key] for key in keys}


def first_two_digits(n):
    return n//100


def get_partials(first_two, number_list):
    index = bisect.bisect(number_list, 100 * first_two)
    output_list = list()
    number = number_list[index]
    while first_two_digits(number) == first_two:
        output_list.append(number)
        index += 1
        number = number_list[index]
        if index == len(number_list):
            break
    return output_list

get_partials(11, triangular)
get_partials(10, triangular)
get_partials(32, octagonal)


def last_two_digits(n):
    return n % 100


def check_if_uniquely_represented(polygon_dict, number, polygon):
    return number in polygon_dict[polygon][1] and\
    not any([number in polygon_dict[gon][1]
         for gon in polygon_dict.keys() if gon != polygon])

check_if_uniquely_represented(sub_dict(polygon_dict, [3,4,5]), 8128, 3)
check_if_uniquely_represented(sub_dict(polygon_dict, [3,4,5]), 8281, 4)
check_if_uniquely_represented(sub_dict(polygon_dict, [3,4,5]), 2882, 5)


def recursive_search(polygon, full_polygon_dict, sub_polygon_dict=None, prev_polygons=None, prev_values=None):
    if sub_polygon_dict is None:
        sub_polygon_dict = full_polygon_dict
    if prev_polygons is None:
        prev_polygons = list()
    if prev_values is None:
        prev_values = list()
    # print(f'polygon: {polygon}, polygons: {list(full_polygon_dict.keys())}, subpolygons: {list(sub_polygon_dict.keys())}, prev_polygons: {prev_polygons}, prev_values: {prev_values}')
    # if prev_values == [7021, 2116]:
    #     a = 1
    if len(sub_polygon_dict) == 1:
        next_val = 100 * last_two_digits(prev_values[-1]) \
                                         + first_two_digits(prev_values[0])
        if check_if_uniquely_represented(full_polygon_dict, next_val, polygon):
            return prev_values + [next_val]
        else:
            return None

    remaining_polygons = set(sub_polygon_dict.keys()) - {polygon} - set(prev_polygons)
    if len(prev_values) > 0:
        possible_next_values = get_partials(last_two_digits(prev_values[-1]), sub_polygon_dict[polygon][0])
        # print(possible_next_values)
    else:
        possible_next_values = sub_polygon_dict[polygon][0]
    next_dict = sub_dict(sub_polygon_dict, remaining_polygons)
    for next_val in possible_next_values:
        a = 1
        # if check_if_uniquely_represented(full_polygon_dict, next_val, polygon):
        if True:
            for next_polygon in remaining_polygons:
                    solution = recursive_search(next_polygon, full_polygon_dict, next_dict, prev_polygons + [polygon], prev_values + [next_val])
                    if solution is not None:
                        return solution
    return None

prev_values = [8128, 2882]
polygon = 4
prev_polygons = [3, 5]

print(recursive_search(4, {key: polygon_dict[key] for key in [3, 4, 5]}, {key: polygon_dict[key] for key in [4]}, prev_polygons, prev_values))
prev_values = [8128]
polygon = 5
prev_polygons = [3]
print(recursive_search(5, {key: polygon_dict[key] for key in [3, 4, 5]}, {key: polygon_dict[key] for key in [4, 5]}, prev_polygons, prev_values))
print(recursive_search(3, {key: polygon_dict[key] for key in [3, 4, 5]}))
print(recursive_search(3, {key: polygon_dict[key] for key in [3, 4, 5, 6]}))
check_if_uniquely_represented(sub_dict(polygon_dict, [3,4,5,6]), 1035, 3)
check_if_uniquely_represented(sub_dict(polygon_dict, [3,4,5,6]), 2116, 4)
check_if_uniquely_represented(sub_dict(polygon_dict, [3,4,5,6]), 1617, 5)
check_if_uniquely_represented(sub_dict(polygon_dict, [3,4,5,6]), 1770, 6)
print(recursive_search(8, polygon_dict))
print(recursive_search(7, polygon_dict))
print(recursive_search(6, polygon_dict))
print(recursive_search(5, polygon_dict))
print(recursive_search(4, polygon_dict))
print(recursive_search(3, polygon_dict))

for ii in range(3, 9):
    sol = recursive_search(ii, polygon_dict)
    print(sum(sol))

check_if_uniquely_represented(polygon_dict, 2882, 5)
check_if_uniquely_represented(polygon_dict, 1281, 8)
check_if_uniquely_represented(polygon_dict, 8128, 6)
check_if_uniquely_represented(polygon_dict, 2512, 7)