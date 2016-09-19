#from twitter csv files, return all twitter user mentioned by an ego

import os.path
import json
import csv

    
with open('node list.txt', 'r') as f:
    seeds = f.readlines()
    

users = []
for oldname in seeds:
    newname = oldname.strip('\n')
    users.append(newname)

name1 = []
name2 = []
with open('twitter names.csv', 'rt') as f: 
    reader = csv.reader(f, delimiter=',')
    for row in reader:
        name1.append(row[0])
        name2.append(row[1])
print(name1)
print(name2)

#Toggle according to whether retweets are included
subdirectory = "tweets_json 8.28.2016"
output_file1 = open("mentions_all.csv", "w", encoding="utf-8")
output_file2 = open("count_all.csv", "w", encoding="utf-8")
#output_file1 = open("mentions_nrt.csv", "w", encoding="utf-8")
#output_file2 = open("count_nrt.csv", "w", encoding="utf-8")

for screen_name in users:
    data = []
    with open(os.path.join(subdirectory, '{}s_tweets.json'.format(screen_name)), 'rt') as f: 
        for line in f:
            data.append(json.loads(line))
    mention_count = 0
    tweet_count = 0
    tweet_ids = []
    for tweet in data:
#        if 'retweeted_status' in tweet:
#            continue
        if tweet['id'] in tweet_ids:
            continue
        tweet_ids.append(tweet['id'])
        last_date = tweet['created_at']
        tweet_count = tweet_count + 1
        if 'entities' in tweet and len(tweet['entities']['user_mentions']) > 0:
            user_mentions = tweet['entities']['user_mentions']
            for mention in user_mentions:
                mention_count = mention_count + 1
                screen_mention = mention['screen_name']
                print(screen_name,',',screen_mention)
                print(screen_name.replace(' ',''), ',', screen_mention.replace(' ',''), file = output_file1)
    i1 = name1.index(screen_name)
    name = name2[i1]
#    print(name,',',screen_name,',',mention_count,',',tweet_count,',',last_date)
#    print(name,',',screen_name,',',mention_count,',',tweet_count,',',last_date, file = output_file2)
    print(name,screen_name,mention_count,tweet_count,last_date,sep=',')
    print(name,screen_name,mention_count,tweet_count,last_date,sep=',',file = output_file2)
