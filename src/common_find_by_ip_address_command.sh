filter=".[] | select(.NetworkSettings.Networks.${args[--network]}.IPAddress == \"${args[ip]}\")"
case "${args[--only-return]}" in
  names)
    filter+=' | .Name[1:]'
    ;;
  ids)
    filter+=' | .Id'
    ;;
  *)
    filter="[${filter}]"
    ;;
esac

docker_inspect | jq -r "${filter}"