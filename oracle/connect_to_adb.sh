#!/bin/zsh

count=$(terraform output --json | jq -r '.token.value | length')


for i in $(seq 0 $(($count-1)))
do
    ip=$(terraform output --json | jq -r ".ip_address.value[$i]")
    token=$(terraform output --json | jq -r ".token.value[$i]")

    echo "Activate ADB into the instance: $ip"
    curl -u genymotion:$token -k -X POST "https://$ip/api/v1/configuration/adb" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"active\":true,\"active_on_reboot\":true}"

    echo "Connect to ADB : $ip"
    adb connect $ip:5555

done


url="file://$(pwd)/../genymotion.html?"
count=$(terraform output --json | jq -r '.token.value | length')
for i in $(seq 0 $(($count-1)))
do
    ip=$(terraform output --json | jq -r ".ip_address.value[$i]")
    token=$(terraform output --json | jq -r ".token.value[$i]")

    url="${url}ip$(($i+1))=${ip}&"

done

echo "Go to $url"
