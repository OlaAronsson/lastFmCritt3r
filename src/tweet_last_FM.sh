#!/bin/bash

USER=MYLASTFMUSER
KEY=MYLASTFMAPIKEY

# Main
/usr/local/bin/twurl -X POST -H api.twitter.com "/1.1/statuses/update.json?status=♬ This week's top spins on $USER's Last FM
`curl -s  "http://ws.audioscrobbler.com/2.0/?method=user.getWeeklyTrackChart&user=$USER&api_key=$KEY&format=json" | sed s='#'==g | sed s='@'==g | jq -r '[.weeklytrackchart.track[] | .attr.rank, .artist.text, .name]' | grep -v "\]" | grep -v "\[" | paste -d" " - - - | cut -b 3- | sed s#'",'#_#g | sed s#'"'##g | sed s#'  '##g | sed s#'_ '#'_'#g | sed 's/.$//' | sed '/_/{s/_/. /1}' | sed s#_#' : '#g | head -5`" | jq
exit 0

