import time
a=8
b = -3
c=0
sumx1=0
sumx2=0
sumx3=0
while c<1000:
    start=time.time()
    if not ((a %2 == 0) and (b %2 == 0)):
        print("At least one of the numbers is odd")

    x1=time.time()
    print(x1-start)
    sumx1+=x1-start
    
    if (not a % 2 == 0) or (not b % 2 == 0):
        print("At least one of the numbers is odd")
    x2=time.time()
    print(x2-x1)
    sumx2+=x2-x1
    if (a % 2 != 0) or (b % 2 != 0):
        print("At least one of the numbers is odd")
    x3=time.time()
    print(x3-x2)
    sumx3+=x3-x2
    c+=1

print("The average for x1 is: ", sumx1/c, " and for x2: ", sumx2/c, " and for x3: ", sumx3/c)
