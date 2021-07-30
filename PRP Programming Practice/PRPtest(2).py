'''
stuff=['a', 2, 2.3, None, type(4), True]

for element in stuff:
    print(type(element))
'''
cnet = [['a', 'b', 'c'], ['second list', 'c2']]
print(cnet)
cnet.append(['db3'])
print(cnet)
cnet[2].append(['db4'])
print(cnet)
cnet2 = [['a']]
print(cnet2)
cnet2.append([])
print(cnet2)
cnet3 = [['a', 'b', 'c'], ['second list', 'c2'], ['more stuff']]
print(len(cnet3))
if 'more stuff' in cnet3:
    print(True)
else:
    print(False)

emptyList = [['a']]
print(len(emptyList))
'''
nn = []
print(nn)
nn.append('a')
print(nn)
nn.append('a')
print(nn)
'''

''' Keep Code:

                    for i in range(len(cnet)-1):  

'''
