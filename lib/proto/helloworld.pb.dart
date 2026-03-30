// Generated from proto/helloworld.proto
// Normally you'd run scripts/gen_protos.sh but I've committed these
// so the project works without protoc installed

// @dart = 2.12

// ignore_for_file: annotate_overrides, deprecated_member_use

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class HelloRequest extends $pb.GeneratedMessage {
  HelloRequest._() : super();

  factory HelloRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory HelloRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HelloRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'helloworld'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  HelloRequest clone() => create()..mergeFromMessage(this);

  HelloRequest copyWith(void Function(HelloRequest) updates) =>
      super.copyWith((message) => updates(message as HelloRequest))
          as HelloRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HelloRequest create() => HelloRequest._();

  HelloRequest createEmptyInstance() => create();

  static $pb.PbList<HelloRequest> createRepeated() =>
      $pb.PbList<HelloRequest>();

  @$core.pragma('dart2js:noInline')
  static HelloRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HelloRequest>(create);

  static HelloRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);

  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);

  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class HelloReply extends $pb.GeneratedMessage {
  HelloReply._() : super();

  factory HelloReply.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory HelloReply.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HelloReply',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'helloworld'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  HelloReply clone() => create()..mergeFromMessage(this);

  HelloReply copyWith(void Function(HelloReply) updates) =>
      super.copyWith((message) => updates(message as HelloReply)) as HelloReply;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HelloReply create() => HelloReply._();

  HelloReply createEmptyInstance() => create();

  static $pb.PbList<HelloReply> createRepeated() => $pb.PbList<HelloReply>();

  @$core.pragma('dart2js:noInline')
  static HelloReply getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HelloReply>(create);

  static HelloReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);

  @$pb.TagNumber(1)
  set message($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);

  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
