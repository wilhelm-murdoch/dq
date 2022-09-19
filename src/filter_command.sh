[[ -n "${args[--debug]}" ]] && set -x

docker_inspect | jq -r "${args[filter]}"