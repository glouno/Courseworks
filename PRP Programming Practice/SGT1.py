x=0
while x<3:
    x+=1

print(x)



x=0
y=1
z=0
i=0
while i<5:
    
    z=x+y
    print(z)
    x=y+z
    print(x)
    y=x+z
    print(y)
    i+=1

x=0
y=1
z=x+y
print(z)
i=0
while i<5:
    x=y
    y=z
    z=x+y
    print(z)
    i+=1
