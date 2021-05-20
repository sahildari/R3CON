# R3CON

We have created a bunch of shell scripts to help you up with your recon.
These simple script will help you get all the subdomains and see all the alive subdomains out of all the subdomains we get.

Prerequisites

> - [Sublist3r](https://github.com/aboul3la/Sublist3r)
> - [assetfinder](https://github.com/tomnomnom/assetfinder)
> - [httprobe](https://github.com/tomnomnom/httprobe)
> - [findomain](https://github.com/Findomain/Findomain)

## Usage

> sudo bash subdomain.sh target.com

- It will create alive.txt and alive.json in which all the alive subdomains will be listed.
- It will create headers directory to store the file by trying Open-redirect via `X-Forwarded-Host: evil.com` 
- It will create script and scriptresponse directories to store all the js files related to the target and subdomains of the target (Where all the gold relies).
- It will create endpoints directories to store the intereting endpoints it will find.
- After all this you can use your manual searching for the things you want(grep)

## Example : 
- `grep -iErn 302` to search what subdomains encountered the redirection and then check those subdomains manually
- `grep -iErn admin` 
- `grep -iErn secret-key`

and you get the point. :)

Happy Hacking!
