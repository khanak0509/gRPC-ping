import 'package:args/args.dart';
import 'package:grpc_ping/client.dart';
import 'package:grpc_ping/printer.dart';
import 'package:grpc_ping/result.dart';
import 'package:grpc_ping/server.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption('host', defaultsTo: 'localhost')
    ..addOption('port', defaultsTo: '50051')
    ..addOption('name', defaultsTo: 'grpc_ping')
    ..addFlag('tls', defaultsTo: false)
    ..addFlag('local', defaultsTo: true, negatable: true)
    ..addOption('call', allowed: ['unary', 'streaming', 'all'], defaultsTo: 'all');

  final opts = parser.parse(args);
  final host = opts['host'] as String;
  final port = int.parse(opts['port'] as String);
  final name = opts['name'] as String;
  final tls = opts['tls'] as bool;
  final local = opts['local'] as bool;
  final call = opts['call'] as String;

  LocalServer? server;
  late final PingClient client;
  var actualHost = host;
  var actualPort = port;

  if (local) {
    server = LocalServer();
    await server.start();
    actualHost = 'localhost';
    actualPort = server.port;
    client = PingClient(actualHost, actualPort, tls: tls);
  } else {
    client = PingClient(host, port, tls: tls);
  }

  final results = <PingResult>[];
  if (call == 'unary' || call == 'all') {
    results.add(await client.unary(name: name));
  }
  if (call == 'streaming' || call == 'all') {
    results.add(await client.streaming(name: name));
  }

  Printer().printTable(results, target: '$actualHost:$actualPort');

  await client.close();
  if (server != null) {
    await server.stop();
  }
}
