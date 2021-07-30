def number_checker(a, b):
    if (a > b):
        return True
    elif (a < 0):
        return True
    elif (a < 0) and (b > 0):
        return True
    return False
    
number_checker(-10, -5)
number_checker(-10, 5)

