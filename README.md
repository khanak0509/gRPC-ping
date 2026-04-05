# grpc_ping

A tiny Dart CLI tool for poking gRPC servers and timing the results. I built this to really understand how gRPC channels work in Dart — not just the happy path, but the lifecycle, connection reuse, and all the little details you only notice when you build something yourself.

## Running it

```sh
dart pub get
dart run bin/grpc_ping.dart
```

That’s it. You’ll see a table of results from the embedded test server — no setup needed.

## Connecting to a real server

```sh
dart run bin/grpc_ping.dart --no-local --host myserver.com --port 50051
```

## All flags

| Flag      | Description                  | Default      |
|-----------|------------------------------|--------------|
| --host    | server host                  | localhost    |
| --port    | server port                  | 50051        |
| --name    | name in request              | grpc_ping    |
| --tls     | use TLS                     | false        |
| --local   | run embedded server          | true         |
| --call    | unary\|streaming\|all        | all          |

## What the output looks like

```
╔══════════════════════════════╗
║      grpc_ping  v0.1.0       ║
║   Dart gRPC Testing Tool     ║
╚══════════════════════════════╝
Target: localhost:50051

METHOD                TYPE        STATUS    LATENCY     REQ      RES      MSGS
─────────────────────────────────────────────────────────────────────────────
SayHello              Unary       OK        11 ms       14 B     28 B     1
SayHelloStreamReply   Streaming   OK        287 ms      14 B     140 B    5

✓ 2/2 calls succeeded  |  total latency: 298 ms
```

If any call fails, you’ll see the error in red below the table.

## Regenerating the protos

If you want to re-generate the Dart files from proto (not needed unless you’re hacking on the proto):

```sh
bash scripts/gen_protos.sh
```

You’ll need `protoc` and the Dart plugin installed.

## Tests

```sh
dart test
```

---

