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

filter='.[] | select((.State.StartedAt | split(".")[0] | "\(.)Z" | fromdate) > $threshold) | '
if [[ "${args[--return-ids-only]}" ]]; then
  filter+='.Id'
else
  filter+='.Name[1:]'
fi

docker_inspect | jq --argjson threshold "${relative_epoch}" -r "${filter}"