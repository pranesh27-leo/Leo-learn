#!/usr/bin/env bash
# Thin wrapper so you can run `./lp due` from the repo root.
exec "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/learning/lp.sh" "$@"
