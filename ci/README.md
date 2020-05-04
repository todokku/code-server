# ci

This directory contains scripts used for code-server's continuous integration infrastructure.

Many of these scripts contain more detailed documentation and options in comments at the top.

## dev

This directory contains scripts used for the development of code-server.

- [./dev/container](./dev/container)
  - See [CONTRIBUTING.md](../doc/CONTRIBUTING.md) for docs on the development container
- [./dev/ci.sh](./dev/ci.sh) (`yarn ci`)
  - Runs formatters, linters and tests
- [./dev/fmt.sh](./dev/fmt.sh) (`yarn fmt`)
  - Runs formatters
- [./dev/lint.sh](./dev/lint.sh) (`yarn lint`)
  - Runs linters
- [./dev/test.sh](./dev/test.sh) (`yarn test`)
  - Runs tests
- [./dev/vscode.sh](./dev/vscode.sh) (`yarn vscode`)
  - Ensures `lib/vscode` is cloned, patched and dependencies are installed
- [./dev/vscode.patch](./dev/vscode.patch)
  - Our patch of VS Code to enable remote browser access
  - Generate it with `yarn vscode:diff` and apply with `yarn vscode:patch`
- [./dev/watch.ts](./dev/watch.ts) (`yarn watch`)
  - Starts a process to build and launch code-server and restart on any code changes
  - Example usage in [CONTRIBUTING.md](../doc/CONTRIBUTING.md)

## build

This directory contains the scripts used to build code-server.

- [./build/build-code-server.sh](./build/build-code-server.sh) (`yarn build`)
  - Builds code-server into ./out and bundles the frontend into ./dist.
- [./build/build-vscode.sh](./build/build-vscode.sh) (`yarn build`)
  - Builds vscode into ./lib/vscode/out-vscode.
- [./build/build-release.sh](./build/build-release.sh) (`yarn release`)
  - Bundles the output of the above two scripts into a single node module at ./release.
- [./build/clean.sh](./build/clean.sh) (`yarn clean`)
  - Removes all git ignored files like build artifacts.
  - Will also `git reset --hard lib/vscode`
  - Useful to do a clean build.
  - Will build a static release if `PACKAGE_NODE=1` is set.
- [./build/code-server.sh](./build/code-server.sh)
  - Copied into static releases to run code-server with the bundled node binary.
- [./build/archive-release.sh](./build/archive-release.sh)
  - Archives `./release` into a tar/zip for CI with the proper directory name scheme
- [./build/test-release.sh](./build/test-release.sh)
  - Ensures code-server in the `./release` directory runs

## release-container

This directory contains the release docker container.

## steps

This directory contains the steps used in CI. It helps avoid
