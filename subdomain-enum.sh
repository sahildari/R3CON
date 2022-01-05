#!/bin/bash

CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"



## running subfinder
echo -e "${CYAN} [+] Starting Subfinder${ENDCOLOR}\n"
subfinder -silent -d $1 -o domains.txt
echo -e "\n"

#runing assetfinder
echo -e "${CYAN}[+] Starting assetfinder${ENDCOLOR}\n"
assetfinder --subs-only $1 | tee -a domains.txt

echo -e "\n"

#running findomain-linux
echo -e "${CYAN}[+]Starting findomain-linux${ENDCOLOR}\n"
findomain-linux --output --quiet --target $1
echo -e "\n"

echo -e "${GREEN}[+] Subdomain Enumeration completed${ENDCOLOR}"
echo -e "\n\n"

#removing dublicate entries
cat "$1.txt" >> domains.txt
rm "$1.txt"

sort -u domains.txt -o domains.txt

echo -e "${YELLOW}[+] All unique Subdomains have been written to domains.txt${ENDCOLOR}"

echo -e "\n\n"
echo -e "${CYAN}[+] Checking for alive domains..${ENDCOLOR}\n"
cat domains.txt | httprobe | tee -a alive.txt


cat alive.txt | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > alive.json
cat domains.txt | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > domains.json
