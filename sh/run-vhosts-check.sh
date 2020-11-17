#!/usr/bin/env bash

# Var
i=0;
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
VHOSTFILE="./config/vhosts.txt"

#########################################################

VHOSTS[i++]="localhost"

VHOSTS[i++]="localhost:8090"
VHOSTS[i++]="localhost:9999"

if [[ -f "$VHOSTFILE" ]]
then
  LINES=$(cat $VHOSTFILE)
	for LINE in $LINES
  do
    arr=($(echo "$LINE" | tr '|' ' '))
    VHOSTS[i++]="${arr[0]}"
  done
fi

#########################################################

function validate_url(){
    echo -n "${1} -> ";
    if [[ `wget -S -t 2 --timeout=2 --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]];
      then echo -e "${GREEN}ok${NC}";
      else echo -e "${RED}fail${NC}";
    fi
}
#########################################################

for VHOST in ${VHOSTS[*]}
do
    validate_url $VHOST
done
