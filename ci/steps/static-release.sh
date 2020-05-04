#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."

  yarn
  yarn vscode
  yarn build
  yarn release
  ./ci/build/test-release.sh
  ./ci/build/package-static-release.sh
}

main "$@"
