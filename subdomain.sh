#!/bin/bash

CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"

echo -e "${CYAN}=================================================================================================="
echo -e "${CYAN}======================== WELCOME TO R3CON AUTOMATION SCRIPT ========================${ENDCOLOR}"
echo -e "${CYAN}==================================================================================================${ENDCOLOR}"
#calling subdomain-enum.sh
echo -e "\n\n"
echo -e "${YELLOW}[+] Using the subdomain-enum.sh now.....${ENDCOLOR}"
subdomain-enum.sh "$1"

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
