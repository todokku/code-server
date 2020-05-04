#!/usr/bin/env bash
set -euo pipefail

code-server_version() {
  jq -r .version package.json
}

pushd() {
  builtin pushd "$@" > /dev/null
}

popd() {
  builtin popd > /dev/null
}
