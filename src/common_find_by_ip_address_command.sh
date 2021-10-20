filter='.[] | select(.NetworkSettings.Networks[$network].IPAddress == $ip)'
if [[ "${args[--return-ids-only]}" ]]; then
    filter+=' | .Id'
else
    filter+=' | .Name[1:]'
fi

docker_inspect | jq \
    --arg network "${args[--network]}" \
    --arg ip "${args[ip]}" \
    -r "${filter}"