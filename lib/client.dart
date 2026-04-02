import 'package:grpc/grpc.dart';

import 'proto/helloworld.pbgrpc.dart';
import 'result.dart';

class PingClient {
  final ClientChannel _channel;
  late final GreeterClient _stub;

  PingClient(String host, int port, {bool tls = false})
      : _channel = ClientChannel(
          host,
          port: port,
          options: ChannelOptions(
            credentials: tls
                ? const ChannelCredentials.secure()
                : const ChannelCredentials.insecure(),
          ),
        ) {
    _stub = GreeterClient(_channel);
  }

  Future<PingResult> unary({String name = 'grpc_ping'}) async {
    final req = HelloRequest.create()..name = name;
    final sw = Stopwatch()..start();
    try {
      final resp = await _stub.sayHello(req);
      sw.stop();
      return PingResult(
        method: 'SayHello',
        callType: 'Unary',
        status: 'OK',
        latency: sw.elapsed,
        requestBytes: req.writeToBuffer().length,
        responseBytes: resp.writeToBuffer().length,
        messageCount: 1,
      );
    } on GrpcError catch (e) {
      sw.stop();
      return PingResult.failed(
        method: 'SayHello',
        callType: 'Unary',
        status: e.codeName,
        latency: sw.elapsed,
        error: e.message,
      );
    }
  }

  Future<PingResult> streaming({String name = 'grpc_ping'}) async {
    final req = HelloRequest.create()..name = name;
    final sw = Stopwatch()..start();
    var totalBytes = 0;
    var msgCount = 0;
    try {
      final stream = _stub.sayHelloStreamReply(req);
      await for (final reply in stream) {
        totalBytes += reply.writeToBuffer().length;
        msgCount++;
      }
      sw.stop();
      return PingResult(
        method: 'SayHelloStreamReply',
        callType: 'Streaming',
        status: 'OK',
        latency: sw.elapsed,
        requestBytes: req.writeToBuffer().length,
        responseBytes: totalBytes,
        messageCount: msgCount,
      );
    } on GrpcError catch (e) {
      sw.stop();
      return PingResult.failed(
        method: 'SayHelloStreamReply',
        callType: 'Streaming',
        status: e.codeName,
        latency: sw.elapsed,
        error: e.message,
      );
    }
  }

  Future<void> close() => _channel.shutdown();
}
