#!/bin/bash

CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"

set -euo pipefail
if [[ $# -ne 1 ]]; then
  echo -e "${RED}[!] Usage: $0 <domain_name>${ENDCOLOR}"
  exit 1
fi

echo -e "${CYAN}==================================================================================================${ENDCOLOR}"
echo -e "${CYAN}======================== WELCOME TO R3CON AUTOMATION SCRIPT ======================================${ENDCOLOR}"
echo -e "${CYAN}==================================================================================================${ENDCOLOR}"
#calling subdomain-enum.sh
echo -e "\n\n"
echo -e "${YELLOW}[+] Using the subdomain-enum.sh now.....${ENDCOLOR}"
subdomain-enum.sh "$1"

echo -e "=================================================================================================="
#calling cut.sh

echo -e "\n\n"
echo -e "${YELLOW}[+] Using cut.sh now.....${ENDCOLOR}"
cut.sh $1/alive.txt

echo -e "=================================================================================================="
#calling jsfiles.sh

echo -e "\n\n"
echo -e "${YELLOW}[+] Using the jsfiles.sh now .....${ENDCOLOR}"
jsfiles.sh $1/alive.txt

echo -e "=================================================================================================="
#calling endpoint.sh 

echo -e "\n\n"
echo -e "${YELLOW}[+] Using the endpoint.sh file now....${ENDCOLOR}"
endpoint.sh $1/alive.txt

echo -e "=================================================================================================="

echo -e "${GREEN}[+] EXECUTION COMPLETED ${ENDCOLOR}"
