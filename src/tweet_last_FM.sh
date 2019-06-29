#!/bin/bash

# Required
USER=MYLASTFMUSER
KEY=MYLASTFMAPIKEY

# Options
COMPACT=0
NOOFTRACKS=5

# You need to provide these
echo $USER | grep "MYLASTFM" > /dev/null 2>&1 && echo "You need to provide your Last FM User" && exit 1
echo $KEY | grep "MYLASTFM" > /dev/null 2>&1 && echo "You need to provide your Last FM API key" && exit 1

# Main
if [ $COMPACT -eq 0 ]; then
  /usr/local/bin/twurl -X POST -H api.twitter.com "/1.1/statuses/update.json?status=�~Y� $USER's Last FM says `curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$USER&api_key=$KEY&format=json" | sed s='#'==g | sed s='@'==g | jq -r '[.weeklytrackchart.track[] | .attr.rank, .artist.text, .name]' | grep -v "\]" | grep -v "\[" | paste -d" " - - - | head -$NOOFTRACKS | cut -b 3- | sed s#'",'#_#g | sed s#'"'##g | sed s#'  '##g | sed s#'_ '#'_'#g | sed 's/.$//' | sed 's/^/(/' | sed '/_/{s/_/) /1}' | sed s#_#':'#g | tr '\n' ' '`#lastFmCritt3r" | jq
else
  /usr/local/bin/twurl -X POST -H api.twitter.com "/1.1/statuses/update.json?status=�~Y� This week's top spins on $USER's Last FM
`curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$USER&api_key=$KEY&format=json" | sed s='#'==g | sed s='@'==g | jq -r '[.weeklytrackchart.track[] | .attr.rank, .artist.text, .name]' | grep -v "\]" | grep -v "\[" | paste -d" " - - - | head -$NOOFTRACKS | cut -b 3- | sed s#'",'#_#g | sed s#'"'##g | sed s#'  '##g | sed s#'_ '#'_'#g | sed 's/.$//' | sed '/_/{s/_/. /1}' | sed s#_#' : '#g`#lastFmCritt3r" | jq
fi


exit 0


