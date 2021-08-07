#!/bin/bash

CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"



## running subfinder
echo -ne "${CYAN} [+] Starting Subfinder${ENDCOLOR}\n"
subfinder -silent -d $1 -o domains.txt
echo -ne "\n"

#runing assetfinder
echo -ne "${CYAN}[+] Starting assetfinder${ENDCOLOR}\n"
assetfinder --subs-only $1 | tee -a domains.txt

echo -ne "\n"

#running findomain-linux
echo -ne "${CYAN}[+]Starting findomain-linux${ENDCOLOR}\n"
findomain-linux --output --quiet --target $1
echo -ne "\n"

echo -ne "${GREEN}[+] Subdomain Enumeration completed${ENDCOLOR}"
echo -ne "\n\n"

#removing dublicate entries
cat "$1.txt" >> domains.txt
rm "$1.txt"

sort -u domains.txt -o domains.txt

echo -ne "${YELLOW}[+] All unique Subdomains have been written to domains.txt${ENDCOLOR}"

echo -ne "\n\n"
echo -ne "${CYAN}[+] Checking for alive domains..${ENDCOLOR}\n"
cat domains.txt | httprobe | tee -a alive.txt


cat alive.txt | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > alive.json
cat domains.txt | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > domains.json


