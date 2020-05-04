#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."

  yarn

  # We do not `yarn vscode` to make test.sh faster.
  git submodule update --init
  # If the patch fails to apply, then it's likely already applied
  yarn vscode:patch &> /dev/null || true

  yarn ci
}

main "$@"
