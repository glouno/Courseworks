def fibonacci(n):
    print(n)
    if n==1:
        return 1 # base case
    elif n==2:
        return 1 # base case
    else:
        
        return fibonacci(n-1) + fibonacci(n-2) # recursive case: two recursive calls

#print (fibonacci(20)) #this will probably be slow or break.

print(fibonacci(7))
# Is there a more efficient recursive solution?
