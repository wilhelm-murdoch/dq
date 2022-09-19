set -eo pipefail

[[ -n "${args[--debug]}" ]] && set -x

if ! command -v "jq" &> /dev/null; then
  echo "$(red_bold [ERR]) jq could not be located. Install using the relevant command:"
  echo "$(red_bold [ERR])   MacOS: $ brew update && brew install jq"
  echo "$(red_bold [ERR])   Linux: $ apt-get install jq"
fi