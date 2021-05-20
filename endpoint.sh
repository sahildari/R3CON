#!/bin/bash
#looping through the scriptsresponse directory
mkdir -p endpoints
CUR_DIR=$(pwd)
for domain in $(ls scriptsresponse)
do
        #looping through files in each domain
        mkdir -p endpoints/$domain
        for file in $(ls scriptsresponse/$domain)
        do
                ruby /YOUR-PATH-TO-extract.rb scriptsresponse/$domain/$file >> endpoints/$domain/$file 
        done
done
