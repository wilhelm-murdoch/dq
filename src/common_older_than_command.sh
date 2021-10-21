[[ ! "${other_args[*]}" ]] && {
  echo 'Please, specify a GNU date-compatible relative time string.'
  exit 1
}

if [[ "${OSTYPE}" == 'darwin'* ]]; then
  if ! command -v gdate &> /dev/null; then
    echo 'Please, install gdate before continuing. You can do this using Homebrew with:'
    echo '$ brew install coreutils'
    exit 1
  fi

  relative_epoch=$(gdate -d "${other_args[*]} ago" +%s)
else
  relative_epoch=$(date -d "${other_args[*]} ago" +%s)
fi

filter='.[] | select((.State.StartedAt | split(".")[0] | "\(.)Z" | fromdate) < $threshold)'
case "${args[--only-return]}" in
  ips)
    filter+=" | .NetworkSettings.Networks.${args[--network]}.IPAddress"
    ;;
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

docker_inspect | jq --argjson threshold "${relative_epoch}" -r "${filter}"