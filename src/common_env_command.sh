filter='[.[].Config.Env] | flatten | unique'
if [[ "${args[--name]}" ]]; then
  filter=".[] | select(.Name == \"/${args[--name]}\") | .Config.Env"
elif [[ "${args[--id]}" ]]; then
  filter=".[] | select(.Id == ${args[--id]}) | .Config.Env"
elif [[ "${args[--ip-address]}" ]]; then
  filter=".[] | select(.NetworkSettings.Networks.${args[--network]}.IPAddress == \"${args[--ip-address]}\") | .Config.Env"
fi

if [[ "${args[--return-as]}" == 'flags' ]]; then
  filter="[${filter} | \"--env=\(.[])\"] | join(\" \")"
else
  filter+=' | .[]'
fi

docker_inspect | jq -r "${filter}"