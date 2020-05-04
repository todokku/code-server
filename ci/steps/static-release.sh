#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."

  yarn
  yarn vscode
  yarn build
  PACKAGE_NODE=true yarn release
  ./ci/build/test-release.sh
  ./ci/build/archive-release.sh
}

main "$@"
