stack=[]
stack.append('apple')
stack.extend(['pear', 'banana', 'tomato'])
print (stack)

print(stack.pop(1))

letters = ['a', 'b', 'c', 'd']
new_list_1 = letters
new_list_2 = letters[:]
letters[2] = 'e'
print(new_list_1)
print(new_list_2)

x = [1, 2]
y = [1, 2]
print(x == y)
print(x is y)
x=y
print(x is y)
