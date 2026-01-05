#!/bin/bash

CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"

set -euo pipefail

domainName="${1:-}"

# Empty check
if [[ -z "$domainName" ]]; then
  echo -e "${RED}[!] Please provide a domain name as an argument.\nExample: ./subdomain-enum.sh example.com\n${ENDCOLOR}"
  exit 1
fi

# Validate allowed characters: letters, digits, dot, dash, underscore
if [[ ! "$domainName" =~ ^[A-Za-z0-9._-]+$ ]]; then
  echo -e "${RED}[!] Invalid domain name. Only letters, digits, '.', '-', and '_' are allowed.${ENDCOLOR}" 
  exit 1
fi

# Build paths
domainDirectory="$(pwd)/$domainName"
mkdir -p "$domainDirectory"

dynamicDomainPath="$domainDirectory/$domainName.txt"
sortedFilePath="$domainDirectory/$domainName-sorted.txt"
alivePath="$domainDirectory/alive.txt"
aliveJsonPath="$domainDirectory/alive-$domainName.json"
domainJsonPath="$domainDirectory/domains-$domainName.json"

# Overwrite confirmation if files exist
if [[ -f "$dynamicDomainPath" ]]; then
  echo -e "${YELLOW}[-] The file $dynamicDomainPath is already present in $domainDirectory, do you want to overwrite it? (y/n): ${ENDCOLOR}"
  read -r response
  response="${response,,}"   # to lowercase
  if [[ "$response" != "y" ]]; then
    echo -e "${YELLOW}[-] Exiting script. Please rename or remove the existing file and try again.${ENDCOLOR}"
    exit 1
  else
    rm -f "$dynamicDomainPath"
  fi
fi

echo -e "${CYAN}[+] Starting Subdomain Enumeration on $domainName${ENDCOLOR}\n"

#running findomain-linux
echo -e "${CYAN}[+]Starting findomain${ENDCOLOR}\n"
findomain --quiet --target "$domainName" --unique-output "$dynamicDomainPath"
echo -e "${GREEN}===findomain completed===${ENDCOLOR}\n"

## running subfinder
echo -e "${CYAN} [+] Starting Subfinder${ENDCOLOR}\n"
subfinder -silent -d "$domainName" | tee -a "$dynamicDomainPath"
echo -e "${GREEN}===subfinder completed===${ENDCOLOR}\n"

#runing assetfinder
echo -e "${CYAN}[+] Starting assetfinder${ENDCOLOR}\n"
assetfinder --subs-only "$domainName" | tee -a "$dynamicDomainPath"
echo -e "${GREEN}===assetfinder completed===${ENDCOLOR}\n"

echo -e "${GREEN}[+] Subdomain Enumeration completed${ENDCOLOR}\n"

# Remove duplicates
if [[ -s "$dynamicDomainPath" ]]; then
  sort -u "$dynamicDomainPath" > "$sortedFilePath"
  mv "$sortedFilePath" "$dynamicDomainPath"
fi

echo -e "${GREEN}[+] All unique subdomains have been written to $dynamicDomainPath${ENDCOLOR}\n\n"


echo -e "${CYAN}[*] Checking for alive domains..${ENDCOLOR}\n"
cat "$dynamicDomainPath" | httprobe | tee -a "$alivePath"


cat "$alivePath" | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > "$aliveJsonPath"
cat "$dynamicDomainPath" | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > "$domainJsonPath"