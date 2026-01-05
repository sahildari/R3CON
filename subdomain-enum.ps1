try {
    $domainName = $args[0]

    if ([string]::IsNullOrEmpty($domainName)) {
        Write-Host "Please provide a domain name as an argument.`r`nExample: .\subdomain-enum.ps1 example.com" -ForegroundColor Red
        exit
    }
    
    # Validate allowed characters: letters, digits, dot, dash, underscore
    if($domainName -notmatch '^[A-Za-z0-9._-]+$') {
        Write-Host "Invalid domain name. Only letters, digits, '.', '-', and '_' are allowed." -ForegroundColor Red
        exit
    }

    # Build the full path safely
    $domainDirectory = Join-Path -Path $PWD -ChildPath $domainName
    if (-not (Test-Path -Path $domainDirectory)) {
        New-Item -ItemType Directory -Path $domainDirectory | Out-Null
    }

    # $domainPath        = Join-Path -Path $domainDirectory -ChildPath "domains.txt"
    $domainJsonPath    = Join-Path -Path $domainDirectory -ChildPath "domains-$domainName.json"
    $dynamicDomainPath = Join-Path -Path $domainDirectory -ChildPath "$domainName.txt"
    $sortedFilePath    = Join-Path -Path $domainDirectory -ChildPath "$domainName-sorted.txt"
    $alivePath         = Join-Path -Path $domainDirectory -ChildPath "alive-$domainName.txt"
    $aliveJsonPath     = Join-Path -Path $domainDirectory -ChildPath "alive-$domainName.json"

    if ((Test-Path -Path $dynamicDomainPath) -and (Test-Path -Path $domainPath)) {
        Write-Host "The file $domainName.txt and $domainPath is already present in $domainDirectory, do you want to overwrite it? (y/n): " -ForegroundColor Red
        $response = Read-Host
        if ($response.ToLower() -ne 'y') {
            Write-Host "Exiting script. Please rename or remove the existing file and try again." -ForegroundColor Yellow
            exit
        }
        else {
            Remove-Item $dynamicDomainPath
            Remove-Item $domainPath
        }
    }

    Write-Host "[+] Starting Subdomain Enumeration on $domainName`r`n`r`n" -ForegroundColor Green

    #running Findomain
    Write-Host "[+]Starting findomain" -ForegroundColor Cyan
    findomain --quiet --target $domainName --unique-output $dynamicDomainPath
    Write-Host "`r`n===findomain completed===`r`n" -ForegroundColor Green

    ## running subfinder
    Write-Host "[+] Starting Subfinder" -ForegroundColor Cyan
    subfinder -silent -d $domainName | Tee-Object -FilePath $dynamicDomainPath -Append
    Write-Host "`r`n===Subfinder completed===`r`n" -ForegroundColor Green

    #runing assetfinder
    Write-Host "[+] Starting assetfinder" -ForegroundColor Cyan
    assetfinder --subs-only $domainName | Tee-Object -FilePath $dynamicDomainPath -Append
    Write-Host "`r`n===assetfinder completed===`r`n" -ForegroundColor Green

    Write-Host "[+] Subdomain Enumeration completed`r`n" -ForegroundColor Green

    #removing duplicate entries
    if((Test-Path -Path $dynamicDomainPath) -and (Get-Content $dynamicDomainPath).Length -gt 0){
        Get-Content "$dynamicDomainPath" -encoding Unicode | Sort-Object -Unique | Tee-Object -FilePath $sortedFilePath -Append
        Remove-Item "$dynamicDomainPath"
        Rename-Item "$sortedFilePath" "$dynamicDomainPath"
    }
    
    Write-Host "[+] All unique Subdomains have been written to $dynamicDomainPath `r`n" -ForegroundColor Green

    Write-Host "[+] Checking for alive domains with httpx..`r`n" -ForegroundColor Cyan
    New-Item -ItemType File -Path $domainDirectory -Name "alive-$domainName.txt" | Out-Null
    Get-Content "$dynamicDomainPath" | httprobe | Tee-Object -FilePath $alivePath -Append
    Write-Host "[+] Execution Completed Successfully and all alive domains have been written to $alivePath`r`n" -ForegroundColor Green

    Get-Content "$alivePath" -encoding Unicode | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > $aliveJsonPath
    Get-Content "$dynamicDomainPath" -encoding Unicode | python3 -c "import sys; import json; print (json.dumps({'domains':list(sys.stdin)}))" > $domainJsonPath
    }
catch{
    Write-Host "[!] An error occurred: $_" -ForegroundColor Red
}