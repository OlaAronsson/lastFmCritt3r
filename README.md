# **lastFmCritt3r 2.0**  
some-liner to tweet your top 5 Last FM scrobbles

Requirements:

1. You are a linux user (well, of course you are)  
2. You have setup a Last FM API key  
   - how to do this simple procedure is described at https://www.last.fm/api  
3. You have a fresh 2.x Twitter App registered at your Twitter Development Portal  
   - log in, go to https://developer.twitter.com/en/portal/dashboard, set it up  
4. You have installed a FRESH python, pip and the tweepy python module required  

In the script exchange

1. LAST_FM_USER_ID with your user
2. LAST_FM_API_KEY with your Last FM API key

That's it. It should work fine, posting stuff like

♬ This week's top spins on olamattias's Last FM  
1. Damon Albarn : The Selfish Giant  
2. Jai Paul : BTSTU - Demo  
3. Jai Paul : Zion Wolf Theme - Unfinished  
4. Cocteau Twins : Cherry-Coloured Funk  
5. Cocteau Twins : The Itchy Glowbo Blow  

or

♬ olamattias's Last FM says (1) Damon Albarn:The Selfish Giant (2) Jai Paul:BTSTU - Demo (3) Jai Paul:Zion Wolf Theme - Unfinished (4) Cocteau Twins:Cherry-Coloured Funk (5) Cocteau Twins:The Itchy Glowbo Blow

to your twitter account having COMPACT toggled to 0.

Now just crontab -e and set it up for a weekly run.

https://twitter.com/dah0l3

# ** Note ** 

On my Fedora (38) the script "just worked". On an old mint (that is Debian) machine I had I had to upgrade

* openssl manually (see for instance https://unix.stackexchange.com/questions/696381/upgrading-openssl-to-version-3-0-2-from-source) to version OpenSSL 3.0.2
* install python3.9 and pip3.9 and change all versions in the script of these to python3.9 resp pip3.9
* run # pip3.9 install urllib3==1.26.6

an NOW it works proper.

