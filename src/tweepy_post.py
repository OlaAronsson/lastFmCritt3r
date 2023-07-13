import tweepy

def __post_inner(tweet: str, silent: bool):
    
    if bool (tweet and tweet.strip()):

        ########################################################
        #
        # Below details should be, while
        #
        # a) being logged in
        # b) having setup your access tokens for read AND write
        # at your project page reached from
        #
        # https://developer.twitter.com/en/portal/dashboard
        #
        ########################################################
        
        consumer_key = "TWITTER_API_KEY"
        consumer_secret = "TWITTER_API_SECRET"
        access_token = "TWITTER_ACCESS_TOKEN"
        access_token_secret = "TWITTER_ACCESS_TOKEN_SECRET"

        client = tweepy.Client(
            consumer_key=consumer_key, consumer_secret=consumer_secret,
            access_token=access_token, access_token_secret=access_token_secret)

        if silent:
            try:
                response = client.create_tweet(
                    text=tweet
                )
                resp_id = str({response.data['id']})    
                if bool (resp_id and resp_id.strip()):
                    print("0")
                else:
                    print("1")
            except:
                print("1")
        else:
            response = client.create_tweet(
                text=tweet
            )
            resp_id = str({response.data['id']})    
            if bool (resp_id and resp_id.strip()):
                print("0")
            else:
                print("1")            
    else:        
        print("1")

def post_to_twitter_silent(tweet: str):
    __post_inner(tweet, True)
def post_to_twitter(tweet: str):
    __post_inner(tweet, False)
