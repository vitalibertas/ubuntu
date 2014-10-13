#!/bin/bash

publicIpFile="/home/user/public.ip"
logFile="/home/user/publicIp.log"
email="user@domain.com"

function writeNewIp {
    printf "$newIp\n" > $publicIpFile
    echo "The new public IP is $newIp." | mail -s "New public IP: $newIp" -r `hostname -f`@domain.com $email 2>> $logFile
}

function checkPublicIp {
    if [ ! -f "$publicIpFile" ]; then
        touch $publicIpFile
    else
        publicIp=$(cat $publicIpFile)
        newIp=$(curl ifconfig.me/ip)
    fi

    if [ -z "$publicIp" ]; then
        writeNewIp
    else
        if [ $newIp != $publicIp ]; then
            writeNewIp
        fi
    fi
}

checkPublicIp
