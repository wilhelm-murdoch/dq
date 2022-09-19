[[ -n "${args[--debug]}" ]] && set -x

docker_inspect | jq -r ".[].NetworkSettings.Networks.${args[--network]}.IPAddress"