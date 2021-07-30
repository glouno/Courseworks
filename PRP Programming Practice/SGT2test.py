def number_checker(a, b):
    if (a > b):
        return True
    elif (a < 0):
        return True
    elif (a < 0) and (b > 0):
        return True
    return False
    

def i(my_number):
        my_number = my_number + 1
        return(my_number)
x=5
print(x)
print(i(x))
print(x)

def p(my_list):
        original_order = my_list[:]
        my_list.reverse()
        return (original_order == my_list)
numbers = [1,2,5,2,4]
print(numbers)
p(numbers)
print(numbers)
