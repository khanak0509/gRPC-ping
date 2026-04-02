import 'dart:async';

import 'package:grpc/grpc.dart';

import 'proto/helloworld.pbgrpc.dart';

class GreeterService extends GreeterServiceBase {
  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) async {
    return HelloReply.create()..message = 'Hello, ${request.name}!';
  }

  @override
  Stream<HelloReply> sayHelloStreamReply(
      ServiceCall call, HelloRequest request) async* {
    for (var i = 0; i < 5; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      yield HelloReply.create()..message = 'Hello, ${request.name}! [$i]';
    }
  }
}

class LocalServer {
  Server? _server;

  int get port => _server?.port ?? 0;

  Future<void> start() async {
    _server = Server.create(services: [GreeterService()]);
    await _server!.serve(port: 0);
  }

  Future<void> stop() async {
    await _server?.shutdown();
    _server = null;
  }
}
