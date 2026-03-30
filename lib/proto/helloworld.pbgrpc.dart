// Generated from proto/helloworld.proto
// Normally you'd run scripts/gen_protos.sh but I've committed these
// so the project works without protoc installed

// @dart = 2.12

// ignore_for_file: annotate_overrides, library_prefixes, non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'helloworld.pb.dart' as $0;

export 'helloworld.pb.dart';

@$pb.GrpcServiceName('helloworld.Greeter')
class GreeterClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/helloworld.Greeter/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));

  static final _$sayHelloStreamReply =
      $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
          '/helloworld.Greeter/SayHelloStreamReply',
          ($0.HelloRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));

  GreeterClient(
    $grpc.ClientChannel channel, {
    $grpc.CallOptions? options,
    $core.Iterable<$grpc.ClientInterceptor>? interceptors,
  }) : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloReply> sayHello(
    $0.HelloRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseStream<$0.HelloReply> sayHelloStreamReply(
    $0.HelloRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
      _$sayHelloStreamReply,
      $async.Stream.fromIterable([request]),
      options: options,
    );
  }
}

@$pb.GrpcServiceName('helloworld.Greeter')
abstract class GreeterServiceBase extends $grpc.Service {
  $core.String get $name => 'helloworld.Greeter';

  GreeterServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHelloStreamReply',
        sayHelloStreamReply_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloReply> sayHello_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Stream<$0.HelloReply> sayHelloStreamReply_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.HelloRequest> request) async* {
    yield* sayHelloStreamReply(call, await request);
  }

  $async.Future<$0.HelloReply> sayHello(
      $grpc.ServiceCall call, $0.HelloRequest request);

  $async.Stream<$0.HelloReply> sayHelloStreamReply(
      $grpc.ServiceCall call, $0.HelloRequest request);
}
