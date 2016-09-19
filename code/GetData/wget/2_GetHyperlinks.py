from bs4 import BeautifulSoup
import requests
import os
import pandas as pd
import csv

regex = r"(?<=^|(?<=[^a-zA-Z0-9-_\.]))@([A-Za-z_]+[A-Za-z0-9_]+)"

output_file = open("all hyperlinks.csv", "w", encoding="utf-8")

with open('links_folder list.txt', 'r') as f:
    seeds = f.readlines()
    
urls = []
for oldname in seeds:
    newname = oldname.strip('\n')
    urls.append(newname)
print(urls)    

direct = "wget_files_robots"


for root, dirs, files in os.walk(".", topdown=False):
    for name in files:
        for sender in urls:
            if sender in os.path.join(root, name):   
                try:
                    my_file = open(os.path.join(root, name), 'r', encoding="utf8", errors="ignore")
                except:
                    pass
                page_text = my_file.read()   
                soup = BeautifulSoup(page_text.encode('UTF-8'), 'lxml')
                for line in soup.find_all("a"):
                    href = str(line.get('href'))
                    if href.startswith("http", 0, 4):
                        for receiver in urls:
                            if receiver==sender:
                                continue
                            if receiver in href:
#                        if "twitter" not in href and "facebook" not in href and "vimeo" not in href and "instagram" not in href and "flickr" not in href and "youtube" not in href and "linkedin" not in href:
                                output = sender + "," + receiver
                                print(output)
                                print(output, file = output_file)
