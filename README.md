# **lastFmCritt3r 2.0**  
some-liner to tweet your top 5 Last FM scrobbles

Requirements:

1. You are a linux user (well, of course you are)  
2. You have setup a Last FM API key  
   - how to do this simple procedure is described at https://www.last.fm/api  
3. You have a fresh 2.x Twitter App registred at your Twitter development portal  
   - Log in, go to https://developer.twitter.com/en/portal/dashboard, set it up  
4. You have installed a FRESH python, pip and the tweepy python module.  

In the script exchange

1. MYLASTFMUSER with your user
2. MYLASTFMAPIKEY with your Last FM API key

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
