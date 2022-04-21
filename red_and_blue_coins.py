import random
from math import comb
import numpy as np
import copy

"""
In front of you are two stacks of coins, one of red coins and one of blue coins.
One of the colors are all fair coins, and the other color are all weighted with
the same weighting. You know that the weighted coins have either a 60% or a 40%
chance of returning heads, but you don't know which.You are told to take any
number of coins from each of the stacks, then to flip all the coins at once.
What is the minimum number of total coins you can take and still have a 75% or
better chance of being able to look at the result of the flipping and tell me
which color is weighted and which weighting it has? How many of each color coin
do you take, and what do you guess for each flip result?
How would your strategy change if your required level of certainty increased or
decreased? How would your strategy change if the weighting changed to 90% and
10%?
"""

"""
Clarification 1:
Can the strategy take the results of the flips into account? Or do you have to
decide up front how many of each you will flip?
"""


def pmf(n, k, p):
    return comb(n, k) * p**k * (1 - p) ** (n - k)


class State:
    def __init__(self, red_flips=0, red_heads=0,
                 blue_flips=0, blue_heads=0, bias=0.6):
        self.red_flips = red_flips
        self.red_heads = red_heads
        self.blue_flips = blue_flips
        self.blue_heads = blue_heads
        self.bias = bias

    def flip_red(self, heads):
        self.red_flips += 1
        if heads:
            self.red_heads += 1

    def flip_blue(self, heads):
        self.blue_flips += 1
        if heads:
            self.blue_heads += 1

    def __copy__(self):
        return State(self.red_flips, self.red_heads,
                     self.blue_flips, self.blue_heads, self.bias)

    def __str__(self):
        return f'state: red: {self.red_heads}/{self.red_flips}; blue: {self.blue_heads}/{self.blue_flips}'

    def probability_of_biases(self):
        """
        Return, in an ordered list:
        - The probability that red is heads_biased (probabilty of {bias}) (RHB)
        - The probability that red is tails_biased (probabilty of {1 -bias}) (RTB)
        - The probability that blue is heads_biased (probabilty of {bias}) (BHB)
        - The probability that blue is tails_biased (probabilty of {1 -bias}) (BTB)

        P(State|RHB) = pmf(rf, rh, bias) * pmf(bf, bh, 0.5)
        P(State|RTB) = pmf(rf, rh, 1 - bias) * pmf(bf, bh, 0.5)
        P(State|BHB) = pmf(rf, rh, 0.5) * pmf(bf, bh, bias)
        P(State|BTB) = pmf(rf, rh, 0.5) * pmf(bf, bh, 1 - bias)

        P(RHB) = P(RTB) = P(BHB) = P(BTB) = 0.25
        P(State) = unkown

        Bayes theorem:
        P(A | B) = P(B | A) * P(A) / P(B)

        ->

        P(RHB|State) = P(State|RHB) * P(RHB) / P(State) = P(State|RHB) * 0.25 / P(State)
        P(RTB|State) = P(State|RTB) * P(RTB) / P(State) = P(State|RTB) * 0.25 / P(State)
        P(BHB|State) = P(State|BHB) * P(BHB) / P(State) = P(State|BHB) * 0.25 / P(State)
        P(BTB|State) = P(State|BTB) * P(BTB) / P(State) = P(State|BTB) * 0.25 / P(State)
        sum(P(RHB|State), P(RTB|State), P(BHB|State), P(BTB|State)) = 1;
        so we can ignore the 0.25/P(State) and normalize
        """

        p_rhb = pmf(self.red_flips, self.red_heads, self.bias) * \
                pmf(self.blue_flips, self.blue_heads, 0.5)
        p_rtb = pmf(self.red_flips, self.red_heads, 1 - self.bias) * \
                pmf(self.blue_flips, self.blue_heads, 0.5)
        p_bhb = pmf(self.red_flips, self.red_heads, 0.5) * \
                pmf(self.blue_flips, self.blue_heads, self.bias)
        p_btb = pmf(self.red_flips, self.red_heads, 0.5) * \
                pmf(self.blue_flips, self.blue_heads, 1 - self.bias)

        prob_biases = np.array([p_rhb, p_rtb, p_bhb, p_btb])

        return prob_biases / sum(prob_biases)


class Strategy:
    def __init__(self, necessary_threshold=0.75):
        self.necessary_threshold = necessary_threshold

    def pick(self, state):
        """
        For base strategy, random picking
        """
        return random.randint(0, 1)


class NaiveStrategy(Strategy):
    def __init__(self, necessary_threshold=0.75):
        super().__init__(necessary_threshold=necessary_threshold)

    def pick(self, state):
        """
        Pick uniformly - if picks from Red/Blue are uneven, even them out,
        otherwise, pick red
        """
        if state.red_flips == state.blue_flips:
            return 1
        else:
            return 0


class InformationEntropyStrategy(Strategy):
    def __init__(self, bias=0.6, necessary_threshold=0.75):
        super().__init__(necessary_threshold=necessary_threshold)
        self.bias = bias
        self.bias_matrix = np.array([[self.bias, 1 - self.bias, 0.5, 0.5],
                                     [1 - self.bias, self.bias, 0.5, 0.5],
                                     [0.5, 0.5, self.bias, 1 - self.bias],
                                     [0.5, 0.5, 1 - self.bias, self.bias],
                                     ])

    def pick(self, state):
        """
        probability of heads on red is:
        bias * P(RBH) + (1 - bias) * P(RBT) + 0.5 * (P(BBH) + P(BBT)
        probability of tails on red is:
        (1 - bias) * P(RBH) + bias * P(RBT) + 0.5 * (P(BBH) + P(BBT)
        probability of heads on blue is:
        0.5 * (P(RBH) + P(RBT) + bias * P(BBH) + (1 - bias) * P(BBT)
        probability of tails on red is:
        0.5 * (P(RBH) + P(RBT) + (1 - bias) * P(BBH) + bias * P(BBT)
        """
        current_probability_of_biases = state.probability_of_biases()
        current_prob = max(current_probability_of_biases)
        probs = np.dot(self.bias_matrix, current_probability_of_biases)

        #RH
        prob_rh = probs[0]
        state_rh = copy.copy(state)
        state_rh.flip_red(True)
        prob_bias_rh = max(state_rh.probability_of_biases())

        #RT
        prob_rt = probs[1]
        state_rt = copy.copy(state)
        state_rt.flip_red(False)
        prob_bias_rt = max(state_rt.probability_of_biases())

        prob_r = prob_rh * prob_bias_rh + prob_rt * prob_bias_rt

        #BH
        prob_bh = probs[2]
        state_bh = copy.copy(state)
        state_bh.flip_blue(True)
        prob_bias_bh = max(state_bh.probability_of_biases())

        #BT
        prob_bt = probs[3]
        state_bt = copy.copy(state)
        state_bt.flip_blue(False)
        prob_bias_bt = max(state_bt.probability_of_biases())

        prob_b = prob_bh * prob_bias_bh + prob_bt * prob_bias_bt
        print(current_prob)
        print(prob_b - current_prob, prob_r - current_prob)
        choice = np.argmax([prob_b, prob_r])
        return choice

strategy = InformationEntropyStrategy()
for ii in range(100):
    red_flips = random.randint(0, 20)
    red_heads = random.randint(int(0.2 * red_flips), int(0.8 * red_flips))
    blue_flips = random.randint(0, 20)
    blue_heads = random.randint(int(0.2 * blue_flips), int(0.8 * blue_flips))
    state = State(red_flips, red_heads, blue_flips, blue_heads)
    print(state)
    choice = strategy.pick(state)
    print(choice)




def simulate(strategy, threshold=None, bias=0.6, lim=1000, verbose=True):
    ordering = ['red heads', 'red tails', 'blue heads', 'blue tails']
    red_biased = random.randint(0, 1)
    heads_biased = random.randint(0, 1)
    position_in_ordering = 2 * (not red_biased) + (not heads_biased)
    prh, prt, pbh, pbt = (0.5,) * 4
    correct = None
    if red_biased:
        if heads_biased:
            prh = bias
            prt = 1 - bias
        else:
            prh = 1 - bias
            prt = bias
    else:
        if heads_biased:
            pbh = bias
            pbt = 1 - bias
        else:
            pbh = 1 - bias
            pbt = bias
    if verbose:
        print(f'plaintext: {ordering[position_in_ordering]}')
        print(f'biased coin: {"red" if red_biased else "blue"}')
        print(f'biased side: {"heads" if heads_biased else "tails"}')
        print(f'probability: red heads, red tails, blue heads, blue tails: {prh, prt, pbh, pbt}')
    state = State()
    for flip in range(lim):
        if verbose:
            print(f'flip number {flip}')
        flip_red = strategy.pick(state)
        if flip_red:
            result = random.choices([1, 0], [prh, prt])[0]
            state.flip_red(result)
        else:
            result = random.choices([1, 0], [pbh, pbt])[0]
            state.flip_blue(result)
        probability_of_biases = state.probability_of_biases()
        if verbose:
            print(f'probability of biases: {probability_of_biases}')
        max_prob = max(probability_of_biases)
        position = np.argmax(probability_of_biases)
        correct = position == position_in_ordering
        if threshold:
            if max_prob > threshold:
                if verbose:
                    print(f'terminating after {flip + 1} flips, bias is {100 * max_prob}% > {100 * threshold}% likely to be: {ordering[position]} and was {"correct" if correct else "incorrect"}')
                print(f'state: red: {state.red_heads}/{state.red_flips}; blue: {state.blue_heads}/{state.blue_flips}')
                return flip + 1, correct
        else:
            if verbose:
                print(f'after {flip + 1} flips, bias is {100 * max_prob}% likely to be: {ordering[position]} and was {"correct" if correct else "incorrect"}')

    return None, correct


simulate(Strategy(), threshold=None, bias=0.6, lim=100)
simulate(Strategy(), threshold=0.75, bias=0.6, lim=150)
simulate(NaiveStrategy(), threshold=0.75, bias=0.6, lim=150)


def repeat_simulations_assuming_given_number_of_flips(strategy, bias=0.6, flips =100, lim=1000):
    corrects = 0
    for ii in range(lim):
        _, correct = simulate(strategy, threshold=None, bias=bias, lim=flips, verbose=False)
        if correct:
            corrects += 1
    prob = corrects/lim
    return prob


def iterate_for_minimal_flips(strategy, bias=0.6, lim=1000, threshold=0.75, start=95, end=150):
    for flips in range(start, end):
        prob = repeat_simulations_assuming_given_number_of_flips(strategy, bias, flips, lim)
        if prob > threshold:
            return flips


print(iterate_for_minimal_flips(Strategy()))
print(iterate_for_minimal_flips(NaiveStrategy()))


def repeat_simulations_assuming_adaptive_number_of_flips(strategy, threshold=0.75, bias=0.6, lim=1000):
    corrects = 0
    numbers = 0
    sims = 0
    for ii in range(lim):
        number, correct = simulate(strategy, threshold=threshold, bias=bias, verbose=False)
        print(number, correct)
        if number is None:
            continue
        sims += 1
        if correct:
            corrects += 1
        numbers += number
    prob = corrects/sims
    average_number_flips = numbers/sims
    return prob, average_number_flips


repeat_simulations_assuming_adaptive_number_of_flips(Strategy())
repeat_simulations_assuming_adaptive_number_of_flips(NaiveStrategy())
repeat_simulations_assuming_adaptive_number_of_flips(InformationEntropyStrategy())
