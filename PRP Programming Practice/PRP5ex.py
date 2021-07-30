x=float(input("x variable:"))
y=float(input("y variable:"))

if not((x %2 == 0) or (y %2 == 0)):
    print("B")
    print (x)
    print (y)

elif (x %2 == 0) and (y %2 == 0):
    #print("Both values are multiples of 5")
    print("A")

else:
    print("C")

'''x = int(input("x variable:"))
y = int(input("y variable:"))

if (x % 2 == 0) and (y % 2 == 0):
    #print("Both values are multiples of 5")
    print("A")

elif (x % 2 == 0) or (y % 2 == 0):
    print("C")

else:
    print("B")
'''
