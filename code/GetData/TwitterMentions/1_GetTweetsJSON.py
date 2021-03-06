import os.path
import encoding_fix
import tweepy
import csv
import json
import time

from twitter_authentication import CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET

auth = tweepy.OAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)
auth.set_access_token(ACCESS_TOKEN, ACCESS_TOKEN_SECRET)

api = tweepy.API(auth)
#Define dump folder name
subdirectory = dump_folder

def get_all_tweets(screen_name):
#Twitter only allows access to a users most recent 3240 tweets with this method
	
#authorize twitter, initialize tweepy
#	auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
#	auth.set_access_token(access_key, access_secret)
#	api = tweepy.API(auth)

    tweet_csv_file = open(os.path.join(subdirectory,'{}s_tweets.csv'.format(screen_name)), 'w', encoding='utf-8') 
    csv_writer = csv.writer(tweet_csv_file)
    csv_writer.writerow(["id","created_at","text"])

    tweet_json_backup_file = open(os.path.join(subdirectory,'{}s_tweets.json'.format(screen_name)), 'w', encoding='utf-8')
    
	#initialize a list to hold all the tweepy Tweets
    alltweets = []	
    
#    print("{} total tweets downloaded so far".format(count))
	#make initial request for most recent tweets (200 is the maximum allowed count)
    new_tweets = api.user_timeline(screen_name = screen_name,count=200)
	
    #save most recent tweets
    alltweets.extend(new_tweets)
	
	#save the id of the oldest tweet less one
    oldest = alltweets[-1].id - 1
    
	#keep grabbing tweets until there are no tweets left to grab
    while len(new_tweets) > 0:
        update1 = "getting tweets before {}s".format(oldest)
        print(update1)

	    #all subsuquent requests use the max_id param to prevent duplicates
        new_tweets = api.user_timeline(screen_name = screen_name,count=200,max_id=oldest)
		
		#save most recent tweets
        alltweets.extend(new_tweets)
		
		#update the id of the oldest tweet less one
        oldest = alltweets[-1].id - 1
		
        update2 = "...{}s tweets downloaded so far".format(len(alltweets))
        print(update2)
        

	
	    #transform the tweepy tweets into a 2D array that will populate the csv	
    for tweet in alltweets:
        csv_writer.writerow([tweet.id_str, tweet.created_at, tweet.text.encode("utf-8")])
        tweet_json_backup_file.write(json.dumps(tweet._json))
        tweet_json_backup_file.write("\n")
	
    tweet_json_backup_file.close()
    tweet_csv_file.close()


with open('node list.txt', 'r') as f:
    seeds = f.readlines()
    
print(type(seeds))
print(seeds)

users = []
for oldname in seeds:
    newname = oldname.strip('\n')
    users.append(newname)
print(users)
    
#users = ['AWCities', 'kirklandgov', 'LakeStevensWA']

count = 0
for user in users: 
    #count = count + len(alltweets)
#    print("{} total tweets downloaded so far".format(count))
    print('Working on {} tweets'.format(user))
    if __name__ == '__main__':
	#pass in the username of the account you want to download
        get_all_tweets(user)
        count = count + 1
        print("tweets from {} users gathered".format(count))
        if count >= 10:
            time.sleep(900)
            count = 0
