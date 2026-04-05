import 'package:test/test.dart';
import 'package:grpc_ping/result.dart';

void main() {
  group('PingResult', () {
    test('ok is true for OK', () {
      final r = PingResult(
        method: 'SayHello',
        callType: 'Unary',
        status: 'OK',
        latency: Duration(milliseconds: 10),
        requestBytes: 1,
        responseBytes: 2,
        messageCount: 1,
      );
      expect(r.ok, isTrue);
    });

    test('ok is false for UNAVAILABLE', () {
      final r = PingResult(
        method: 'SayHello',
        callType: 'Unary',
        status: 'UNAVAILABLE',
        latency: Duration(milliseconds: 10),
        requestBytes: 1,
        responseBytes: 2,
        messageCount: 1,
      );
      expect(r.ok, isFalse);
    });

    test('PingResult.failed zeroes bytes and message count', () {
      final r = PingResult.failed(
        method: 'SayHello',
        callType: 'Unary',
        status: 'UNAVAILABLE',
        latency: Duration(milliseconds: 10),
        error: 'fail',
      );
      expect(r.requestBytes, 0);
      expect(r.responseBytes, 0);
      expect(r.messageCount, 0);
      expect(r.error, 'fail');
    });

    test('toString includes method name', () {
      final r = PingResult(
        method: 'SayHello',
        callType: 'Unary',
        status: 'OK',
        latency: Duration(milliseconds: 10),
        requestBytes: 1,
        responseBytes: 2,
        messageCount: 1,
      );
      expect(r.toString(), contains('SayHello'));
    });
  });
}
