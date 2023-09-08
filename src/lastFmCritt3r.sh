#!/bin/bash

export PATH=/usr/bin:/usr/sbin::/usr/local/bin:/usr/local/sbin:/sbin:/bin

HERE=`pwd`
EXECDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $EXECDIR

# You need to provide these - LAST FM and TWITTER KEYS

LAST_FM_USER_ID=YOUR_LAST_FM_USER_ID
LAST_FM_API_KEY=YOUR_LAST_FM_API_KEY

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

TWITTER_API_KEY=YOUR_TWITTER_API_KEY
TWITTER_API_KEY_SECRET=YOUR_TWITTER_API_KEY_SECRET
TWITTER_ACCESS_TOKEN=YOUR_TWITTER_ACCESS_TOKEN
TWITTER_ACCESS_TOKEN_SECRET=YOUR_TWITTER_ACCESS_TOKEN_SECRET

# Options
COMPACT=0
NOOFTRACKS=5
SHOW_TWEET_PROBLEMS=1

chkVariable(){
    v="${1}"
    eval var=\$$v    
    echo "${var}" | grep "YOUR" > /dev/null 2>&1 && return 1
    echo "${var}" | egrep "[a-zA-Z0-9]" > /dev/null 2>&1 && return 0    
    return 1
}

MISSING=
for v in LAST_FM_USER_ID LAST_FM_API_KEY TWITTER_API_KEY TWITTER_API_KEY_SECRET TWITTER_ACCESS_TOKEN TWITTER_ACCESS_TOKEN_SECRET; do
    chkVariable $v || MISSING="$MISSING $v,"
done
[ -n "$MISSING" ] && echo && echo "You need to set the following parameters to run the script : $MISSING" | rev | cut -c2- | rev && echo && exit 1

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
tracks=`curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$LAST_FM_USER_ID&api_key=$LAST_FM_API_KEY&format=json" | cut -d"," -f1 | cut -d":" -f3` 
echo $tracks | egrep "[a-zA-Z]" >/dev/null 2>&1 && ANY_SCROBBLES=0
if [ $ANY_SCROBBLES -eq 1 ]; then
  echo "Got no tracks scrobbled on Last FM!"
  exit 1
fi

# Main
if [ $COMPACT -eq 0 ]; then
  TO_POST="\N{BEAMED SIXTEENTH NOTES} $LAST_FM_USER_ID's Last FM says `curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$LAST_FM_USER_ID&api_key=$LAST_FM_API_KEY&format=json" | sed s='#'==g | sed s='@'==g | jq -r '[.weeklytrackchart.track[] | .attr.rank, .artist.text, .name]' | grep -v "\]" | grep -v "\[" | paste -d" " - - - | head -$NOOFTRACKS | cut -b 3- | sed s#'",'#_#g | sed s#'"'##g | sed s#'  '##g | sed s#'_ '#'_'#g | sed 's/.$//' | sed 's/^/(/' | sed '/_/{s/_/) /1}' | sed s#_#':'#g | tr '\n' ' '`#lastFmCritt3r"
else
  TO_POST="\N{BEAMED SIXTEENTH NOTES} This week's top spins on $LAST_FM_USER_ID's Last FM
`curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$LAST_FM_USER_ID&api_key=$LAST_FM_API_KEY&format=json" | sed s='#'==g | sed s='@'==g | jq -r '[.weeklytrackchart.track[] | .attr.rank, .artist.text, .name]' | grep -v "\]" | grep -v "\[" | paste -d" " - - - | head -$NOOFTRACKS | cut -b 3- | sed s#'",'#_#g | sed s#'"'##g | sed s#'  '##g | sed s#'_ '#'_'#g | sed 's/.$//' | sed '/_/{s/_/. /1}' | sed s#_#' : '#g`#lastFmCritt3r"  
fi

result=
if [ $SHOW_TWEET_PROBLEMS -eq 0 ];then
   result=`python -c "import tweepy_post; tweepy_post.post_to_twitter('''${TO_POST}''')"`
else
   result=`python -c "import tweepy_post; tweepy_post.post_to_twitter_silent('''${TO_POST}''')"`
fi

echo   
[ -z $result ] && echo "Tweet not published." && echo && exit 1
if [ `expr $result` -eq 0 ]; then
    echo "Tweet published fine." && cd $HERE && echo && exit 0
else
    echo "Tweet not published." && cd $HERE && echo && exit 1
fi
