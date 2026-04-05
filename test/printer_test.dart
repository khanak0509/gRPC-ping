import 'dart:io';

import 'package:grpc_ping/printer.dart';
import 'package:grpc_ping/result.dart';
import 'package:test/test.dart';

void main() {
  group('Printer', () {
    test('Does not crash on empty list', () async {
      final output = await _capture([], 'localhost:1234');
      expect(output, isNotEmpty);
    });

    test('Output contains OK for a successful result', () async {
      final result = PingResult(
        method: 'SayHello',
        callType: 'Unary',
        status: 'OK',
        latency: const Duration(milliseconds: 10),
        requestBytes: 1,
        responseBytes: 2,
        messageCount: 1,
      );
      final output = await _capture([result], 'localhost:1234');
      expect(output, contains('OK'));
    });

    test('Summary line says 1/1 for one successful result', () async {
      final result = PingResult(
        method: 'SayHello',
        callType: 'Unary',
        status: 'OK',
        latency: const Duration(milliseconds: 10),
        requestBytes: 1,
        responseBytes: 2,
        messageCount: 1,
      );
      final output = await _capture([result], 'localhost:1234');
      expect(output, contains('1/1'));
    });

    test('Output contains UNAVAILABLE for a failed result', () async {
      final result = PingResult.failed(
        method: 'SayHello',
        callType: 'Unary',
        status: 'UNAVAILABLE',
        latency: const Duration(milliseconds: 10),
        error: 'fail',
      );
      final output = await _capture([result], 'localhost:1234');
      expect(output, contains('UNAVAILABLE'));
    });
  });
}

Future<String> _capture(List<PingResult> results, String target) async {
  final file = File(
      '${Directory.systemTemp.path}/grpc_ping_printer_${DateTime.now().microsecondsSinceEpoch}.txt');
  final sink = file.openWrite();
  Printer(out: sink).printTable(results, target: target);
  await sink.flush();
  await sink.close();
  final text = await file.readAsString();
  await file.delete();
  return text;
}
