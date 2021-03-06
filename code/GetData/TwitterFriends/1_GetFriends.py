import encoding_fix
import tweepy
import time
import os.path
from twitter_authentication import CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

api = tweepy.API(auth)

subdirectory = "Data_followers"


output_file = open(os.path.join(subdirectory, "all_friends.csv"), "w", encoding="utf-8")

ids = []
with open('node list.txt', 'r') as f:
    nodes = f.readlines()
    print(nodes)
    
count = 0
for node1 in nodes:
    follower = api.get_user(node1)
    for page in tweepy.Cursor(api.friends_ids, screen_name=follower.screen_name).pages():
        ids.extend(page)
        print(follower.screen_name)
        update1 = "counted {} so far".format(count)
        print(update1)
        for id in ids:
            count = count + 1
            if count > 15000:
                print("waiting 15 minutes...")
                time.sleep(900)
                count = 0
            print(count)
            update2 = "{},{}".format(follower.screen_name, id)
            print(update2)
            print(update2, file = output_file)      
