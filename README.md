#***lastFmCritt3r 1.0***
one-liner to tweet your top 5 Last FM scrobbles

Requirements:

-You are a linux user (well, of course you are)
-You have setup an Last FM API key       : how to do this simple procedure is described at https://www.last.fm/api
-You have installed and authorized twurl : just google, it's really simple
-You have installed jq                   : of course you have, it's your standard json parser

In the script exchange

1. MYLASTFMUSER with your user
2. MYLASTFMAPIKEY with your Last FM API key

That's it. It should work fine, posting stuff like

♬ This week's top spins on olamattias's Last FM
1_Damon Albarn_The Selfish Giant
2_Jai Paul_BTSTU - Demo
3_Jai Paul_Zion Wolf Theme - Unfinished
4_Cocteau Twins_Cherry-Coloured Funk
5_Cocteau Twins_The Itchy Glowbo Blow

to your twitter account. Now just crontab -e and set it up for a weekly run.

