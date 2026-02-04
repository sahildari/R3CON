#!/bin/bash

CYAN="\e[36m"
ENDCOLOR="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"

set -euo pipefail
if ! command -v go >/dev/null 2>&1; then
  echo -e "${RED}[!] Golang is not installed. Please install Golang to proceed.${ENDCOLOR}"
  exit 1
else
  echo -e "${GREEN}[+] Installing Subfinder.${ENDCOLOR}"
  go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

  echo -e "${GREEN}[+] Installing Findomain.${ENDCOLOR}"
  go install -v github.com/projectdiscovery/findomain/cmd/findomain@latest

  echo -e "${GREEN}[+] Installing Assetfinder.${ENDCOLOR}"
  go install -v github.com/tomnomnom/assetfinder@latest

  echo -e "${GREEN}[+] Installing Httprobe.${ENDCOLOR}"
  go install -v github.com/tomnomnom/httprobe@latest
fi

echo -e "${GREEN}[+] All tools installed successfully.${ENDCOLOR}"
