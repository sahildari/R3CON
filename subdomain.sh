#!/bin/bash

CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"

## running subfinder
echo -e "${CYAN}[+] Starting Subfinder${ENDCOLOR}"
subfinder -silent -d $1 -o domains.txt
echo -e "\n"

#runing assetfinder
echo -e "${CYAN}[+] Starting assetfinder${ENDCOLOR}"
assetfinder --subs-only $1 | tee -a domains.txt

echo -e "\n"

#running findomain
echo -e "${CYAN}[+]Starting findomain${ENDCOLOR}"
findomain --quiet --output --target $1
echo -e "\n"

echo -e "${GREEN}[+] Subdomain Enumeration completed${ENDCOLOR}"
echo -e "\n\n"

##removing dublicate entries
cat "$1.txt" >> domains.txt
rm "$1.txt"

sort -u domains.txt -o domains.txt

echo -e "${YELLOW}[+] All unique Subdomains have been written to domains.txt${ENDCOLOR}"

echo -e "\n\n"
echo -e "${CYAN}[+] Checking for alive domains..${ENDCOLOR}"
cat domains.txt | httprobe | tee -a alive.txt


cat alive.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > alive.json
cat domains.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > domains.json


echo -e "${YELLOW}[+] Finishing things up.....${ENDCOLOR}"

echo -e "\n"

echo -e "${GREEN}[+] All Alive Subdomains have been written to alive.txt${ENDCOLOR}"

echo -e "\n"

echo -e "=================================================================================================="
#calling cut.sh

echo -e "\n\n"
echo -e "${YELLOW}[+] Using cut.sh now.....${ENDCOLOR}"
cut.sh alive.txt

echo -e "=================================================================================================="
#calling jsfiles.sh

echo -e "\n\n"
echo -e "${YELLLOW}[+] Using the jsfiles.sh now .....${ENDCOLOR}"
jsfiles.sh alive.txt

echo -e "=================================================================================================="
#calling endpoint.sh 

echo -e "\n\n"
echo -e "${YELLOW}[+] Using the endpoint.sh file now....${ENDCOLOR}"
endpoint.sh alive.txt

echo -e "=================================================================================================="


echo -e "${GREEN}[+] EXECUTION COMPLETED ${ENDCOLOR}"
