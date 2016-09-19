#from list of all twitter mentions, return only mentions that involve another ego

import csv

output_file1 = open("edgelist_rawAll.csv", "w", encoding="utf-8")
output_file2 = open("edgelist_rawNoRT.csv", "w", encoding="utf-8")

with open('node list.txt', 'r') as f:
    seeds = f.readlines()

users = []
for oldname in seeds:
    newname = oldname.strip('\n')
    users.append(newname)

print(users)

#print only mentions in user list, ignore own-mentions    
with open('mentions_all.csv', 'rt') as f: 
    reader = csv.reader(f, delimiter=',')
#            print(username)
    for row in reader:
        row[0] = row[0].replace(' ','')
        row[1] = row[1].replace(' ','')
        if row[0] == row[1]:
            continue
        if row[1] in users:
            print(row[0],',',row[1])
            print(row[0],',',row[1], file = output_file1)

with open('mentions_nrt.csv', 'rt') as f: 
    reader = csv.reader(f, delimiter=',')
#            print(username)
    for row in reader:
        row[0] = row[0].replace(' ','')
        row[1] = row[1].replace(' ','')
        if row[0] == row[1]:
            continue
        if row[1] in users:
            print(row[0],',',row[1])
            print(row[0],',',row[1], file = output_file2)            
