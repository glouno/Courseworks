#Base Tasks
#Task 1
home_tube_station='southwark'
print(home_tube_station.title())
kcl_tube_station='temple'
print('I cannot go from ' + home_tube_station.title() + ' to ' + kcl_tube_station.title() + ' in one go')

#Task 2
elizabeth_line=['Southwark', 'Temple', 'Dilly', 'Campfire', 'Wonderland', 'Asterix', 'SevenEleven', 'Tricks']

def line_printer(line):
    for station in sorted(line):
        print(station)

#Task 3
def stop_distance(line, origin, destination):
    if origin == destination:
        return 0
    elif origin not in line or destination not in line:
        return -1
    else:
        return abs(line.index(origin) - line.index(destination)) #takes the absolute value to have a positive number of stops in both directions

print(stop_distance(elizabeth_line, 'Southwark', 'Campfire'))

#Task 4
def journey_printer(line, origin, destination):
    if origin and destination not in line:
        return "A station isn't on the line"
    else:
        for i in range(abs(line.index(origin) - line.index(destination))+line.index(origin)+1): #takes the absolute value to have a positive number of stops in both directions, adds origin index to start from origin station and adds 1 to have the last station (because of the range function exclusion)
            print(line[i])

journey_printer(elizabeth_line, 'Southwark', 'Campfire')

#Task 5
def fare(line, origin, destination, flag):
    c=0
    if origin not in line or destination not in line:
        return 0
    elif origin == destination:
        return 0    #because who would pay for the tube without travelling?
    else:
        for i in range(stop_distance(line, origin, destination)):
            if i < 5:
                c += 0.25 #the first four stops are charged 0.25
            else:
                c += 0.2 #the following stops are charged 0.2

    if flag == True:
        c += 2.5 #0.5 surcharge for peake time + base fare
    else:
        c += 2 #base fare

    if c > 3.5:
        c = 3.5 #maximum fare of 3.5

    return c
        
print(fare(elizabeth_line, 'Southwark', 'Campfire', True))

#Task 6
piccadilly = ['Arsenal', 'Kings Cross', 'Holborn', 'Covent Garden']
jubilee = ['Southwark', 'Queensbury', 'Cottage', 'Baker Street', 'Dilly']
tube_network = [('elizabeth_line', elizabeth_line), ('piccadilly', piccadilly), ('jubilee', jubilee)]
def network_printer(network):
    for line in network:    #selects the tuples in the network
        for tube in line:   #selects the elements inside the tuple
            if type(tube) == str:   #index 0 of the tuple is the name of the tube line
                print(tube.title(), ' line:')
            else:
                for station in tube:    #index 1 of the tuple is a list of the tube stations
                    print(station.title())
            #we separated the tuple between index 0 and index 1
        print('\n')

network_printer(tube_network)

#Task 7
def same_line(network, station1, station2):
    for line in network:    #selects the tuples in the network
        flag1 = False   #flags to check if each station is in the line
        flag2 = False
        for tube in line:   #selects the elements inside the tuple
            if type(tube) == str:   #index 0 of the tuple is the name of the tube line so we avoid it and focus on the stations
                pass
            else:                   #index 1 of the tuple is a list of the tube stations which is what we focus on
                for station in tube:    #we check for each station in the line if they are the same as the two station given
                    if station == station1: 
                        flag1 = True
                    elif station == station2:
                        flag2 = True

                if flag1 and flag2 == True: #if both station are in this line, True
                    return True
                else:                       #we go back to the loop to check for the other lines in the network
                    pass

    return False    #if none of the lines have worked, False

print(same_line(tube_network, 'Southwark', 'Dilly'))

#Task8, creating a new database that is quicker to compute on
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
    for cline in cnet:  #selects each list of connected stations in cnet
        for cstation in cline:  #selects each station inside this list
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

