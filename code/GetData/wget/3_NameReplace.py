import os.path
import csv

output_file2 = open("hyperlinks_wget_valued.csv", "w", encoding="utf-8")
output_file1 = open("hyperlinks_wget.csv", "w", encoding="utf-8")

count = 0

urls = []
names = []
f = open('seeds.csv', 'rt')
reader = csv.reader(f, delimiter=',')
for row in reader:
    urls.append(row[0])
    names.append(row[1])        
print(urls)
print(names)

allEdges = []
f = open('all hyperlinks.csv', 'rt')
reader = csv.reader(f, delimiter=',')
for row in reader:
#    for sender in urls:
#        for receiver in urls:        
#            if sender == row[0]:
#                if receiver == row[1]:
    i1 = urls.index(row[0])
    i2 = urls.index(row[1])
    tail = names[i1]
    head = names[i2]
    message1 = tail + "," + head
    print(message1)
    allEdges.append(message1)        
    if allEdges.count(message1) == 1:
        print(message1, file = output_file1)

duplicates = []        
for edge in allEdges:
    count = allEdges.count(edge)
    message2 = edge + "," + str(count)
    if message2 in duplicates:
        continue
    duplicates.append(message2)
    print(message2)
    print(message2, file = output_file2)
