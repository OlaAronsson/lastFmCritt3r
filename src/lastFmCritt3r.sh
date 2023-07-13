#!/bin/bash

# Required
USER=LAST_FM_USER_ID
KEY=LAST_FM_API_KEY

# Options
COMPACT=0
NOOFTRACKS=5
SHOW_TWEET_PROBLEMS=1

# You need to provide these
echo $USER | grep "LAST_FM" > /dev/null 2>&1 && echo "You need to provide your Last FM User" && exit 1
echo $KEY | grep "LAST_FM" > /dev/null 2>&1 && echo "You need to provide your Last FM API key" && exit 1

# Some binaries needed - Python, pip and the tweepy module
BINS_NEEDED="python pip"
for b in ${BINS_NEEDED}; do
    e=`which $b`
    [ -z $e ] && echo "Missing binary $b" && exit 1
done

# ..and we need the tweepy python module 
tw=`pip freeze | grep tweepy`
[ -z $tw ] && echo "Missing python module tweepy - please install it using 'pip install tweepy'." && exit 1

# got any tracks..?
ANY_SCROBBLES=1
tracks=`curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$USER&api_key=$KEY&format=json" | cut -d"," -f1 | cut -d":" -f3` 
echo $tracks | egrep "[a-zA-Z]" >/dev/null 2>&1 && ANY_SCROBBLES=0
if [ $ANY_SCROBBLES -eq 1 ]; then
  echo "Got no tracks scrobbled on Last FM!"
  exit 1
fi

# Main
if [ $COMPACT -eq 0 ]; then
  TO_POST="\N{BEAMED SIXTEENTH NOTES} $USER's Last FM says `curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$USER&api_key=$KEY&format=json" | sed s='#'==g | sed s='@'==g | jq -r '[.weeklytrackchart.track[] | .attr.rank, .artist.text, .name]' | grep -v "\]" | grep -v "\[" | paste -d" " - - - | head -$NOOFTRACKS | cut -b 3- | sed s#'",'#_#g | sed s#'"'##g | sed s#'  '##g | sed s#'_ '#'_'#g | sed 's/.$//' | sed 's/^/(/' | sed '/_/{s/_/) /1}' | sed s#_#':'#g | tr '\n' ' '`#lastFmCritt3r"
else
  TO_POST="\N{BEAMED SIXTEENTH NOTES} This week's top spins on $USER's Last FM
`curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$USER&api_key=$KEY&format=json" | sed s='#'==g | sed s='@'==g | jq -r '[.weeklytrackchart.track[] | .attr.rank, .artist.text, .name]' | grep -v "\]" | grep -v "\[" | paste -d" " - - - | head -$NOOFTRACKS | cut -b 3- | sed s#'",'#_#g | sed s#'"'##g | sed s#'  '##g | sed s#'_ '#'_'#g | sed 's/.$//' | sed '/_/{s/_/. /1}' | sed s#_#' : '#g`#lastFmCritt3r"  
fi

result=
if [ $SHOW_TWEET_PROBLEMS -eq 0 ];then
   result=`python -c "import tweepy_post; tweepy_post.post_to_twitter('''${TO_POST}''')"`
else
   result=`python -c "import tweepy_post; tweepy_post.post_to_twitter_silent('''${TO_POST}''')"`
fi
   
[ -z $result ] && echo "Tweet not published." && exit 1
if [ `expr $result` -eq 0 ]; then
    echo "Tweet published fine." && exit 0
else
    echo "Tweet not published." && exit 1
fi
