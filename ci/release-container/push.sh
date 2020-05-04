#!/usr/bin/env bash

set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."
  source ./ci/lib.sh
  VERSION="$(code-server_version)"

  if [[ ${CI-} ]]; then
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  fi

  imageTag="codercom/code-server:$VERSION"
  if [[ ${TRAVIS_CPU_ARCH-} == "arm64" ]]; then
    imageTag+="-arm64"
  fi
  docker build --build-arg FIXUID_ARCH=${TRAVIS_CPU_ARCH-amd64} -t "$imageTag" -f ./ci/release-container/Dockerfile .
  docker push codercom/code-server
}

main "$@"
