set -eo pipefail

[[ -n "${VERBOSE}" ]] && set -x

if ! command -v jq &> /dev/null; then
  echo 'Please, install jq before continuing: https://stedolan.github.io/jq/download/'
  exit 1
fi