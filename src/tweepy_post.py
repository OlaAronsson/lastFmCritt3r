import tweepy
import os

def __do_post(tweet: str, client: tweepy.Client):
    response = client.create_tweet(
        text=tweet
    )
    resp_id = str({response.data['id']})    
    if bool (resp_id and resp_id.strip()):
        print("0")
    else:
        print("1")      

def __post_inner(tweet: str, silent: bool):
    
    if bool (tweet and tweet.strip()):
        
        client = tweepy.Client(
            consumer_key=os.getenv('TWITTER_API_KEY'), consumer_secret=os.getenv('TWITTER_API_KEY_SECRET'),
            access_token= os.getenv('TWITTER_ACCESS_TOKEN'), access_token_secret=os.getenv('TWITTER_ACCESS_TOKEN_SECRET'))

        if silent:
            try:
                __do_post(tweet, client)                
            except:
                print("1")
        else:
            __do_post(tweet, client)
    else:        
        print("1")

def post_to_twitter_silent(tweet: str):
    __post_inner(tweet, True)
def post_to_twitter(tweet: str):
    __post_inner(tweet, False)
