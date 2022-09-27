[[ -n "${args[--debug]}" ]] && set -x

docker_inspect | jq -r '.[].Name[1:]'