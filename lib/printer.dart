import 'dart:io';

import 'result.dart';

class Printer {
  Printer({IOSink? out}) : _out = out ?? stdout;

  final IOSink _out;

  void printTable(List<PingResult> results, {required String target}) {
    _out.writeln('╔══════════════════════════════╗');
    _out.writeln('║      grpc_ping  v0.1.0       ║');
    _out.writeln('║   Dart gRPC Testing Tool     ║');
    _out.writeln('╚══════════════════════════════╝');
    _out.writeln('Target: $target\n');

    _out.writeln('\x1B[1mMETHOD                TYPE        STATUS    LATENCY     REQ      RES      MSGS\x1B[0m');
    _out.writeln('─────────────────────────────────────────────────────────────────────────────');

    for (final r in results) {
      final typeColor = r.callType == 'Streaming' ? '\x1B[36m' : '';
      final statusColor = r.status == 'OK' ? '\x1B[32m' : '\x1B[31m';
      _out.writeln(
        '${_pad(r.method, 21)}'
        '$typeColor${_pad(r.callType, 11)}\x1B[0m'
        '$statusColor${_pad(r.status, 12)}\x1B[0m'
        '${_pad('${r.latency.inMilliseconds} ms', 11)}'
        '${_pad('${r.requestBytes} B', 9)}'
        '${_pad('${r.responseBytes} B', 9)}'
        '${_pad(r.messageCount.toString(), 7)}'
      );
    }

    final okCount = results.where((r) => r.ok).length;
    final total = results.length;
    final totalLatency = results.fold<int>(0, (sum, r) => sum + r.latency.inMilliseconds);
    _out.writeln('\n✓ $okCount/$total calls succeeded  |  total latency: $totalLatency ms');

    for (final r in results) {
      if (r.error != null) {
        _out.writeln('\x1B[31mError in ${r.method}: ${r.error}\x1B[0m');
      }
    }
  }

  String _pad(String s, int width) {
    if (s.length >= width) return s.substring(0, width);
    return s + ' ' * (width - s.length);
  }
}
