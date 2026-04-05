#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

protoc \
  --dart_out=grpc:lib/proto \
  -I proto \
  proto/helloworld.proto

echo "Wrote Dart stubs under lib/proto/"
