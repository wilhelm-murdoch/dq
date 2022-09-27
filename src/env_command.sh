[[ -n "${args[--debug]}" ]] && set -x

filter='[.[].Config.Env] | flatten | unique'
if [[ "${args[--name]}" ]]; then
  filter=".[] | select(.Name == \"/${args[--name]}\") | .Config.Env"
elif [[ "${args[--id]}" ]]; then
  ids_arr=(${args[--id]})
  ids_str=$(join , "${ids_arr[@]}")

  filter="[.[] | select([.Id] | inside([${ids_str}])) | .Config.Env] | flatten | unique"
elif [[ "${args[--ip-address]}" ]]; then
  filter=".[] | select(.NetworkSettings.Networks.${args[--network]}.IPAddress == \"${args[--ip-address]}\") | .Config.Env"
fi

if [[ "${args[--return-as]}" == 'flags' ]]; then
  filter="[${filter} | \"--env=\(.[])\"] | join(\" \")"
else
  filter+=' | .[]'
fi

docker_inspect | jq -r "${filter}"