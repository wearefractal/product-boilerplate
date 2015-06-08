#!/bin/bash


# Sudo check
if [ "$(whoami)" != "www" ]; then
  echo "This script must be run by the www user" 1>&2
  exit 1
fi


NAME='projectname'

cd /www/$NAME

pm2 kill

echo "$SERVER"

if [ "$SERVER" = "lb-server" ]; then
  pm2 start /www/$NAME/server/ -n www
else
  pm2 start /www/$NAME/server/ -n www -i 2
fi

exit 0
