import numpy as np
import numpy.random as rnd
import matplotlib
matplotlib.use('PS')   # generate postscript output by default
import matplotlib.pyplot as plt

''' 
This function returns a representation of a standard 52-card deck.
https://en.wikipedia.org/wiki/Standard_52-card_deck

The returned value is a list of cards, represented as tuples of the form (F,S), where:
	- F is the face of the card. This can be
		- a number "2"--"10", or
		- a picture "J", "Q", "K", "A" (jack, queen, king, ace).
	- S is the suit of the card. This can be:
		- "H", "D", "S", "C" (hearts, diamonds, spades, clubs).
		
The full card deck is a list of each possible pair of (F,S), such that there is exactly one
of each pair in the deck. This makes 52 unique cards.

You must not edit this function in any way.
'''

'''
def new_deck():
    deck = [] # The deck starts empty, and we will populate it with each card
    faces = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
    suits = ["H", "D", "S", "C"]

    for suit in suits:
        for face in faces:
            deck.append((face, suit))

    return deck


'''
#Your code to be added underneath.
'''
# Task 1
my_deck = new_deck()


# Task 2
def two_random_elements(listelements):
    if len(listelements) < 2:
        return 0
    e1 = listelements[rnd.randint(0, len(listelements))]  # selection of first card
    nlist = listelements[:]  # the spliced list
    nlist.remove(e1)  # removing first card to avoid choosing it again
    e2 = nlist[rnd.randint(0, len(nlist))]  # selection of second card
    return (e1, e2)


for _ in range(3): print(two_random_elements(my_deck))


# Task 3
def card_pair_value(cards):
    if cards[0][0] in 'JQKA':  # gives value of 10 to picture cards
        v1 = 10
    else:
        v1 = int(cards[0][0])  # transforms number cards into integer to give value
    if cards[1][0] in 'JQKA':
        v2 = 10
    else:
        v2 = int(cards[1][0])
    return v1 * v2


for _ in range(3): print(card_pair_value(two_random_elements(my_deck)))

# Task 4
tenThousandList = []  # creates a list with 10 000 pair values
for _ in range(10000):
    tenThousandList.append(card_pair_value(two_random_elements(my_deck)))


def pair_value_hist(cplist):
    plt.hist(cplist, bins=[i for i in range(4, 101)])
    plt.show()


pair_value_hist(tenThousandList)

# Task 5
A = np.matrix('1, 4, 5; 2, 8, 9; 3, 6, 7')
print(A)
print(A.T)  # Transpose
print(A.I)  # Inverse
print(A.T * A.I)  # multiplication of Transpose and Inverse

# Task 6
x = np.arange(0, 4 * np.pi, 0.01)  # creates x values with 0.01 spacing
y = 1 / np.sqrt(2 * np.pi) * np.exp(-0.5 * x * x)  # the y function
plt.plot(x, y)
plt.show()
'''
#Testing for exam
test = [5, 10, 3]
def product(numbers):
    mult = 1
    i = 0
    if len(numbers) == 0:
        return None
    else:
        while i < len(numbers):
            mult = mult * numbers[i]
            i += 1
        return mult

print(product(test))

def f(n, k):
          # assume n and k are non-negative integers
          if k == 0:
              return 1
          elif n < k:
              return 0
          else:
              return f(n-1, k-1) + f(n-1, k)

print(f(8, 2))


def fn(x):
    answer = x*2 + 5
    print(answer)
    print("The result is %d." % answer)
y = fn(2)
print(y)
if y is None:
    print("Nothing was returned.")
else:
    print(-y)

