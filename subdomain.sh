##!/bin/bash
CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"



## running subfinder
echo "${CYAN}[+] Starting Subfinder${ENDCOLOR}"
subfinder -silent -d $1 -o domains.txt
echo "\n"

#runing assetfinder
echo "${CYAN}[+] Starting assetfinder${ENDCOLOR}"
assetfinder --subs-only $1 | tee -a domains.txt

echo "\n"

#running findomain
echo "${CYAN}[+]Starting findomain${ENDCOLOR}"
findomain --quiet --output --target $1
echo "\n"

echo "${GREEN}[+] Subdomain Enumeration completed${ENDCOLOR}"
echo "\n\n"

##removing dublicate entries
cat "$1.txt" >> domains.txt
rm "$1.txt"

sort -u domains.txt -o domains.txt

echo "${YELLOW}[+] All unique Subdomains have been written to domains.txt${ENDCOLOR}"

echo "\n\n"
echo "${CYAN}[+] Checking for alive domains..${ENDCOLOR}"
cat domains.txt | httprobe | tee -a alive.txt


cat alive.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > alive.json
cat domains.txt | python -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > domains.json


echo "${YELLOW}[+] Finishing things up.....${ENDCOLOR}"

echo "\n"

echo "${GREEN}[+] All Alive Subdomains have been written to alive.txt${ENDCOLOR}"

echo "\n"

echo "=================================================================================================="
#calling cut.sh

echo "\n\n"
echo "${YELLOW}[+] Using cut.sh now.....${ENDCOLOR}"
cut.sh alive.txt

echo "=================================================================================================="
#calling jsfiles.sh

echo "\n\n"
echo "${YELLLOW}[+] Using the jsfiles.sh now .....${ENDCOLOR}"
jsfiles.sh alive.txt

echo "=================================================================================================="
#calling endpoint.sh 

echo "\n\n"
echo "${YELLOW}[+] Using the endpoint.sh file now....${ENDCOLOR}"
endpoint.sh alive.txt

echo "=================================================================================================="


echo "${GREEN}[+] EXECUTION COMPLETED ${ENDCOLOR}"
