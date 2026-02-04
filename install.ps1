try {
    # Check if Go is installed
    if (-not (Get-Command go -ErrorAction SilentlyContinue)) {
        Write-Host "[!] Golang is not installed. Please install Golang to proceed." -ForegroundColor Red
        exit 1
    }

    Write-Host "[+] Installing Subfinder." -ForegroundColor Cyan
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

    # Write-Host "[+] Installing Findomain." -ForegroundColor Cyan
    # go install -v github.com/projectdiscovery/findomain/cmd/findomain@latest

    Write-Host "[+] Installing Assetfinder." -ForegroundColor Cyan
    go install -v github.com/tomnomnom/assetfinder@latest

    Write-Host "[+] Installing Httprobe." -ForegroundColor Cyan
    go install -v github.com/tomnomnom/httprobe@latest

    Write-Host "[+] All tools installed successfully." -ForegroundColor Green
}
catch {
    Write-Host "[!] An error occurred: $_" -ForegroundColor Red
    exit 1
}