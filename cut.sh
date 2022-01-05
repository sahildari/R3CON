#!/bin/bash
mkdir -p headers
mkdir -p responsebody
CURRENT_PATH=$(pwd)

echo -e "\n\n\e[32m Starting the cut.sh script now\n"

for x in $(cat $1)
do
        NAME=$(echo $x | awk -F/ '{print $3}')
        curl -X GET -H "X-Forwarded-For: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
        curl -X GET -H "Forwarded-For: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
        curl -X GET -H "Forwarded-Host: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
        curl -X GET -H "Forwarded: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
        curl -X GET -H "X-Forwarded-Host: evil.com" $x -I > "$CURRENT_PATH/headers/$NAME"
        curl -X GET -H "X-Custom-IP-authorization: 127.0.0.1" $x -I > "$CURRENT_PATH/headers/$NAME"
        curl -s -X GET -H "X-Forwarded-For: evil.com" -L $x > "$CURRENT_PATH/responsebody/$NAME"
done

echo -e "\n\n\e[32m Completed the execution of the cut.sh script now :)\n "
