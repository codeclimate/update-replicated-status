#!/bin/sh
set -e

message=$(printf '%s ' "$@")
data=$(jq --null-input --arg message "$message" '{message: $message}')

curl \
  --insecure \
  --request PUT "$REPLICATED_INTEGRATIONAPI/status/v1/startup" \
  --header "Content-Type: application/json" \
  --data "$data"
