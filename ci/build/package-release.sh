#!/usr/bin/env bash
set -euo pipefail

# Generates self contained code-server release for CI.
# This script assumes that the release is built already.

main() {
  cd "$(dirname "${0}")/../.."
  source ./ci/lib.sh

  VERSION="$(code-server_version)"

  local target
  target=$(uname | tr '[:upper:]' '[:lower:]')
  if [[ $target == "linux" ]]; then
    # Alpine's ldd doesn't have a version flag but if you use an invalid flag
    # (like --version) it outputs the version to stderr and exits with 1.
    local ldd_output
    ldd_output=$(ldd --version 2>&1 || true)
    if echo "$ldd_output" | grep -iq musl; then
      target="alpine"
    fi
  fi

  local arch
  arch=$(uname -m | sed 's/aarch/arm/')

  local archive_name="code-server-$VERSION-$target-$arch"
  mkdir -p release-github

  local ext
  if [[ $target == "linux" ]]; then
    ext=".tar.gz"
    tar -czf "release-github/$archive_name$ext" --transform "s/^\.\/release/$archive_name/" ./release
  else
    mv ./release "./$archive_name"
    ext=".zip"
    zip -r "release-github/$archive_name$ext" "./$archive_name"
    mv "./$archive_name" ./release
  fi

  echo "done (release-github/$archive_name)"

  mkdir -p "release-gcp/$VERSION"
  cp "release-github/$archive_name$ext" "./release-gcp/$VERSION/$target-$arch$ext"
  mkdir -p "release-gcp/latest"
  cp "./release-github/$archive_name$ext" "./release-gcp/latest/$target-$arch$ext"
}

main "$@"
