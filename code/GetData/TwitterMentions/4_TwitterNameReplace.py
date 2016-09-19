#from list of egocentric twitter mentions, replace names

import csv

output_file1 = open("edgelist_All.csv", "w", encoding="utf-8")
output_file2 = open("edgelist_All_valued.csv", "w", encoding="utf-8")
output_file3 = open("edgelist_NoRT.csv", "w", encoding="utf-8")
output_file4 = open("edgelist_NoRT_valued.csv", "w", encoding="utf-8")

name1 = []
name2 = []
with open('twitter names.csv', 'rt') as f: 
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        name1.append(row[0])
        name2.append(row[1])
print(name1)
print(name2)

#all twitter
allEdges = []
duplicates = []
with open('edgelist_rawAll.csv', 'rt') as f:
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        row0 = row[0].replace(' ','')
        row1 = row[1].replace(' ','')
        i1 = name1.index(row0)
        i2 = name1.index(row1)
        message = name2[i1] + "," + name2[i2]
        print(message)
        allEdges.append(message)
        if allEdges.count(message) == 1:
            print(message, file = output_file1)       
      
for edge in allEdges:
    count = allEdges.count(edge)
    message2 = edge + "," + str(count)
    if message2 in duplicates:
        continue
    duplicates.append(message2)
    print(message2)
    print(message2, file = output_file2)
    
#no retweets 
allEdges = []
duplicates = []
with open('edgelist_rawnoRT.csv', 'rt') as f:
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        row0 = row[0].replace(' ','')
        row1 = row[1].replace(' ','')
        i1 = name1.index(row0)
        i2 = name1.index(row1)
        message = name2[i1] + "," + name2[i2]
        print(message)
        allEdges.append(message)
        if allEdges.count(message) == 1:
            print(message, file = output_file3)       
      
for edge in allEdges:
    count = allEdges.count(edge)
    message2 = edge + "," + str(count)
    if message2 in duplicates:
        continue
    duplicates.append(message2)
    print(message2)
    print(message2, file = output_file4)
