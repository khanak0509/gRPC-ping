import 'package:test/test.dart';
import 'package:grpc_ping/client.dart';
import 'package:grpc_ping/server.dart';

void main() {
  late LocalServer server;
  late PingClient client;

  setUp(() async {
    server = LocalServer();
    await server.start();
    client = PingClient('localhost', server.port);
  });

  tearDown(() async {
    await client.close();
    await server.stop();
  });

  test('Unary call returns ok', () async {
    final result = await client.unary(name: 'test');
    expect(result.ok, isTrue);
    expect(result.latency, greaterThan(Duration.zero));
    expect(result.requestBytes, greaterThan(0));
  });

  test('Streaming call returns 5 messages', () async {
    final result = await client.streaming(name: 'test');
    expect(result.ok, isTrue);
    expect(result.messageCount, 5);
    expect(result.responseBytes, greaterThan(0));
  });
}
