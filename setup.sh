#!/usr/bin/env bash
# Make the Vulkan whisper.cpp binary runnable from anywhere.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="$DIR/bin:${LD_LIBRARY_PATH:-}"
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
echo "whisper-cli: $DIR/bin/whisper-cli"
exec "$DIR/bin/whisper-cli" "$@"
