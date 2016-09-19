#from list of egocentric hyperlinks, replace webpages with names

import csv

output_file1 = open("edgelist_ICL2.csv", "w", encoding="utf-8")
output_file2 = open("edgelist_ICL2_val.csv", "w", encoding="utf-8")

oldname1 = []
name2 = []
with open('icl2_nodes.csv', 'rt') as f: 
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        oldname1.append(row[0])
        name2.append(row[1])
print(oldname1)
#print(name2)

duplicates = []
name1 = []
for oldname in oldname1:
    sep1 = "://"
    newname = oldname.split(sep1, 1)[1]
    print(newname)
    sep2 = "/"
    newname = newname.split(sep2, 1)[0]
    if newname.startswith("www."):
        sep3 = "www."
        newname = newname.split(sep3, 1)[1]
    name1.append(newname)
print(name1)
print(name2)
        
    

with open('edgelist_rawICL2.csv', 'rt') as f:
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        row0 = row[0].replace(' ','')
        row1 = row[1].replace(' ','')
        i1 = name1.index(row0)
        i2 = name1.index(row1)
        message1 = name2[i1] + "," + name2[i2]
        print(message1)
        print(message1, file = output_file1)       
#        print(message1, file = output_file1)


with open('edgelist_rawICL2_val.csv', 'rt') as f:
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        row0 = row[0].replace(' ','')
        row1 = row[1].replace(' ','')
        row2 = row[2].replace(' ','')
        i1 = name1.index(row0)
        i2 = name1.index(row1)
        message2 = name2[i1] + "," + name2[i2] + ", " + row2
        print(message2)
        print(message2, file = output_file2)       
#        print(message1, file = output_file1)
