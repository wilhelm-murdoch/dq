JQ_OPTS=
filter='[.[].Config.Env] | flatten | unique | .[]'
if [[ "${args[--name]}" ]]; then
  JQ_OPTS="--arg name ${args[--name]}"
  filter='.[] | select(.Name == "/\($name)") | .Config.Env | .[]'
elif [[ "${args[--id]}" ]]; then
  JQ_OPTS="--arg id ${args[--id]}"
  filter='.[] | select(.Id == $id) | .Config.Env | .[]'
elif [[ "${args[--ip-address]}" ]]; then
  JQ_OPTS="--arg network ${args[--network]} --arg ip ${args[--ip-address]}"
  filter='.[] | select(.NetworkSettings.Networks[$network].IPAddress == $ip) | .Config.Env | .[]'
fi

docker_inspect | jq ${JQ_OPTS} -r "${filter}"