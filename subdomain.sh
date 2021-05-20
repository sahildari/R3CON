##!/bin/bash
#starting sublister
sublist3r -d $1 -v -o domains.txt
#runing assetfinder
assetfinder --subs-only $1 | tee -a domains.txt
#find domain
findomain --quiet --output --target $1 
##removing dublicate entries
cat "$1.txt" >> domains.txt
rm "$1.txt"
sort -u domains.txt -o domains.txt
echo "\n\n[+] Checking for alive domains..\n"
cat domains.txt | httprobe | tee -a alive.txt
cat alive.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > alive.json
cat domains.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > domains.json

echo "=================================================================================================="
#calling cut.sh

echo "\n\n"
echo "\e[31m [+] Using cut.sh now....."
cut.sh alive.txt

echo "=================================================================================================="
#calling jsfiles.sh

echo "\n\n"
echo "\e[33m [+] Using the jsfiles.sh now .....\n\n"
jsfiles.sh alive.txt

echo "=================================================================================================="
#calling endpoint.sh 

echo "\n\n"
echo "\e[34m [+] Using the endpoint.sh file now....\n\n"
endpoint.sh alive.txt

echo "=================================================================================================="