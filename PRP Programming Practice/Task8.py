elizabeth_line=['Southwark', 'Temple', 'Dilly', 'Campfire', 'Wonderland', 'Asterix', 'SevenEleven', 'Tricks']
piccadilly = ['Arsenal', 'Kings Cross', 'Holborn', 'Covent Garden']
jubilee = ['Southwark', 'Queensbury', 'Cottage', 'Baker Street', 'Dilly']
pikachu = ['pikapika', 'Holborn', 'Campfire']
blatant = ['disturbing', 'deadmau5', 'mau5trap']
suka = ['disturbing', 'idk', 'wut']
tube_network = [('elizabeth_line', elizabeth_line), ('piccadilly', piccadilly), ('jubilee', jubilee), ('pikachu', pikachu), ('blatant', blatant), ('suka', suka)]
print(tube_network)

def connected(network, station1, station2):
    cnet = []   #cnet for connected network where each index represents a network of connected lines
    for line in network:    #selects the tuples in the network
        flag = False        #flag to detect if new stations are already connected
        i = 0               #counter used to keep track of the cnet index we are on
        for tube in line:   #selects the elements inside the tuple
            if type(tube) == str:
                pass
            else:
                while i<len(cnet): #check for each index in cnet
                    for station in tube:    #check for each station in the line
                        if station in cnet[i]:
                            for station in tube:
                                if station in cnet[i]: #check to avoid duplicates
                                    pass
                                else:
                                    cnet[i].append(station) #append each station to the connected network of index i
                            flag = True     #means the whole line is connected to the network of index i in cnet
                            break
                        else:
                            pass
                    if flag == True:    #by using that second break, we avoid useless computation for the different indexes of cnet
                        break
                    else:
                        pass
                    i+=1

                if flag == False:       #the line is not connected to the previous lines and we need to create a new index
                    cnet.append([])
                    for station in tube:
                        cnet[len(cnet)-1].append(station)   #uses new index to append each station
                else:
                    pass

    c = 0           #counter used to keep track of the cnet index FROM which we check for similar stations
    for cline in cnet:
        for cstation in cline:
            d=1     #counter used to keep track of the cnet index IN which we check for similar stations
            while d<len(cnet):
                if c-d==0:  #avoid lists checking themselves
                    d+=1
                    pass
                else:
                    if cstation in cnet[d]:
                        cnet[d].remove(cstation)    #to avoid duplicates
                        while cnet[d] != []:
                                cnet[c].append(cnet[d].pop(0)) #deletes each value and adds them to the main connection list of index c
                    d+=1
        c+=1
    
    #Now the program that actually verifies if the two stations are connected
    c = 0
    while c<len(cnet):  #check in each index of cnet individually
        if station1 in cnet[c] and station2 in cnet[c]:
            return True
        else:
            pass
        c+=1

    return False

print(connected(tube_network, 'Arsenal', 'Campfire'))


'''
def connected(network, station1, station2):
    cnet = []   #cnet for connected network where each index represents a network of connected lines
    for line in network:    #selects the tuples in the network
        flag = False        #flag to detect if new stations are already connected
        i = 0
        for tube in line:   #selects the elements inside the tuple
            if type(tube) == str:
                pass
            else:
                while i<len(cnet): #check for each index in cnet
                    for station in tube:    #check for each station in the line
                        if station in cnet[i]:
                            for station in tube:
                                cnet[i].append(station) #append each station to the connected network of index i
                            flag = True     #means the whole line is connected to the network of index i in cnet
                            break
                        else:
                            pass
                    if flag == True:    #by using that second break, we avoid useless computation for the different indexes of cnet
                        break
                    else:
                        pass
                    i+=1

                if flag == False:       #the line is not connected to the previous lines and we need to create a new index
                    cnet.append([])
                    for station in tube:
                        cnet[len(cnet)-1].append(station)   #uses new index to append each station
                else:
                    pass

    #Now the program that actually verifies if the two stations are connected
    c = 0
    while c<len(cnet):  #check in each index of cnet individually
        if station1 in cnet[c] and station2 in cnet[c]:
            return True
        else:
            pass
        c+=1

    return False

print(connected(tube_network, 'Southwark', 'Holborn'))
'''
