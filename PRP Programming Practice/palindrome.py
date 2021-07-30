def palindrome(string):
    if len(string) == 0: # base case
        return True
    elif len(string) == 1: # base case
        return True
    else: #recursive case
        if string[0] == string[-1]:
            return palindrome(string[1:-1])
        return False

print palindrome("abc")
