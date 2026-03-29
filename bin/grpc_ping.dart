import 'package:args/args.dart';

import 'package:grpc_ping/client.dart';
import 'package:grpc_ping/printer.dart';
import 'package:grpc_ping/result.dart';
import 'package:grpc_ping/server.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('host', defaultsTo: 'localhost', help: 'Server host')
    ..addOption('port', defaultsTo: '50051', help: 'Server port')
    ..addOption('name', defaultsTo: 'grpc_ping', help: 'Name field in HelloRequest')
    ..addFlag('tls', help: 'Use TLS', defaultsTo: false)
    ..addFlag('local',
        defaultsTo: true,
        negatable: true,
        help: 'Spin up an embedded Greeter server')
    ..addOption('call',
        allowed: ['unary', 'streaming', 'all'],
        defaultsTo: 'all',
        help: 'Which RPC(s) to run');

  final ns = parser.parse(args);
  final host = ns['host'] as String;
  final port = int.parse(ns['port'] as String);
  final name = ns['name'] as String;
  final tls = ns['tls'] as bool;
  final local = ns['local'] as bool;
  final call = ns['call'] as String;

  LocalServer? embedded;
  var connectHost = host;
  var connectPort = port;

  if (local) {
    embedded = LocalServer();
    await embedded.start();
    connectHost = 'localhost';
    connectPort = embedded.port;
  }

  final client = PingClient(connectHost, connectPort, tls: tls);
  final results = <PingResult>[];

  try {
    if (call == 'unary' || call == 'all') {
      results.add(await client.unary(name: name));
    }
    if (call == 'streaming' || call == 'all') {
      results.add(await client.streaming(name: name));
    }
  } finally {
    await client.close();
    if (embedded != null) {
      await embedded.stop();
    }
  }

  final target = '$connectHost:$connectPort';
  Printer().printTable(results, target: target);
}
