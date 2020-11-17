#!/usr/bin/env bash

# Var
NOCOLOR='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
BLUE='\033[1;34m'
VHOSTFILE="./config/vhosts.txt"

################################################### VHOSTS #############################################################
# param 1 - http_host
# param 2 - http_path
# param 3 - php_host
function newVhost {
    cp ./config/tpl/default.conf.dist ./config/vhosts/${1}.conf
    sed -i "s/{{HTTP_HOST}}/${1}/g" ./config/vhosts//${1}.conf
    sed -i "s/{{HTTP_PATH}}/${2}/g" ./config/vhosts//${1}.conf
}
function newVhostDefault {
    cp ./config/tpl/default.conf.dist ./config/vhosts/${1}.conf
    sed -i "s/{{HTTP_HOST}}/localhost/g" ./config/vhosts//${1}.conf
    sed -i "s/{{HTTP_PATH}}/${2}/g" ./config/vhosts//${1}.conf
}
########################################################################################################################

echo ""
echo "Creating vhosts files..."

echo ""
echo "Remove Old Vhosts"
rm -f config/vhosts/*.conf

echo ""
echo "Create Default Localhost Vhosts"
newVhostDefault "default" "\/var\/www\/html"
echo -e "Creating ${GREEN}default.conf${NOCOLOR} file"

echo ""
echo "Create Projects Vhosts:"
if [[ -f "$VHOSTFILE" ]] # If file exists
then
  LINES=$(cat $VHOSTFILE)
  # Create file
	for LINE in $LINES
  do
    arr=($(echo "$LINE" | tr '|' ' '))
    echo -e "Creating ${GREEN}${arr[0]}.conf${NOCOLOR} file"
    newVhost "${arr[0]}" "${arr[1]}"
  done
fi

# Show advice for Entry point
# After files created, don't forget to modify your host system file in /etc/hosts
if [[ -f "$VHOSTFILE" ]]
then
  echo ""
  echo -e "Modify your ${ORANGE}/etc/host${NOCOLOR} file with these lines:"
  LINES=$(cat $VHOSTFILE)
  # Create file
	for LINE in $LINES
  do
    arr=($(echo "$LINE" | tr '|' ' '))
    echo -e "${BLUE}127.0.0.1 ${arr[0]}${NOCOLOR}"
  done
fi

echo ""
echo "All done."
echo ""