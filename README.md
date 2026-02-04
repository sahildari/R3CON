# R3CON

[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
![GitHub issues](https://img.shields.io/github/issues/sahildari/R3CON)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/sahildari/R3CON)

I have created a bunch of shell scripts to help you up with your recon.
These simple script will help you get all the subdomains and see all the alive subdomains out of all the subdomains we get.

Prerequisites

> - [Subfinder](https://github.com/projectdiscovery/subfinder)
> - [assetfinder](https://github.com/tomnomnom/assetfinder)
> - [httprobe](https://github.com/tomnomnom/httprobe)
> - [findomain](https://github.com/Findomain/Findomain)

## Usage

```
git clone https://github.com/sahildari/R3CON
```

```
cd R3CON
```

```
chmod +x *.sh
```

```
./subdomain-enum.sh target.com
```

### Please specify the full path of extract.rb in [endpoint.sh](https://github.com/sahildari/R3CON/blob/main/endpoint.sh) 
For example if you have cloned the [R3CON](https://github.com/sahildari/R3CON/) in your /opt/ directory then change the [11th line](https://github.com/sahildari/R3CON/blob/main/endpoint.sh#L11) to `ruby /opt/R3CON/extract.rb scriptsresponse/$domain/$file >> endpoints/$domain/$file` 

- It will create alive.txt and alive.json in which all the alive subdomains will be listed.
- It will create headers directory to store the file by trying Open-redirect via `X-Forwarded-Host: evil.com` 
- It will create script and scriptresponse directories to store all the js files related to the target and subdomains of the target (Where all the gold relies).
- It will create endpoints directories to store the intereting endpoints it will find.
- After all this you can use your manual searching for the things you want(grep)

## Example for Manual searching : 
- `grep -iErn 302` to search what subdomains encountered the redirection and then check those subdomains manually
- `grep -iErn admin` 
- `grep -iErn secret-key`

and you get the point. :)

Happy Hacking!

## Acknowledgements

R3CON framework have been created by using the open source security tools made by these amazing OPEN SOURCE security community -

> - [PROJECTDISCOVERY](https://github.com/projectdiscovery/)
> - [TOMNOMNOM](https://github.com/tomnomnom/)
> - [FINDOMAIN](https://github.com/Findomain/)
