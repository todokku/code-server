#!/usr/bin/env sh

# This script is intended to be bundled into the self contained releases.
# Runs code-server with the bundled Node binary.

# More complicated than readlink -f or realpath to support macOS.
# See https://github.com/cdr/code-server/issues/1537
get_installation_dir() {
  # We read the symlink, which may be relative from $0.
  dst="$(readlink "$0")"
  # We cd into the $0 directory.
  cd "$(dirname "$0")" || exit 1
  # Now we can cd into the dst directory.
  cd "$(dirname "$dst")" || exit 1
  # Finally we use pwd -P to print the absolute path of the directory of $dst.
  pwd -P || exit 1
}

dir=$(get_installation_dir)
exec "$dir/node" "$dir" "$@"
