import tweepy

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

        ########################################################
        #
        # Below variables can be found at
        #
        #  https://developer.twitter.com/en/portal/dashboard
        #
        # Make sure having setup your access tokens for read
        # _and_ write : default they are read only.
        #
        ########################################################
        
        consumer_key = "1Y9oW2oaWK8SbhGSAEJm9iyQl"
        consumer_secret = "6ay6AJBfZUty02NRNxfdq1JS6inVKi5OTTonhA8mP5cYZrxD4C"
        access_token = "4193726788-TpWIXzYB68QwxKvlxl3lkLkuxhr6nnnG5Ak3nWn"
        access_token_secret = "lMDvZfsAMFGjKZIgAujcyoW6B5c7mpCuWUEhdgcx5LO9U"

        client = tweepy.Client(
            consumer_key=consumer_key, consumer_secret=consumer_secret,
            access_token=access_token, access_token_secret=access_token_secret)

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
