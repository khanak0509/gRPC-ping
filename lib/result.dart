class PingResult {
  final String method;
  final String callType;
  final String status;
  final Duration latency;
  final int requestBytes;
  final int responseBytes;
  final int messageCount;
  final String? error;

  PingResult({
    required this.method,
    required this.callType,
    required this.status,
    required this.latency,
    required this.requestBytes,
    required this.responseBytes,
    required this.messageCount,
    this.error,
  });

  bool get ok => status == 'OK';

  PingResult.failed({
    required String method,
    required String callType,
    required String status,
    required Duration latency,
    String? error,
  }) : this(
          method: method,
          callType: callType,
          status: status,
          latency: latency,
          requestBytes: 0,
          responseBytes: 0,
          messageCount: 0,
          error: error,
        );

  @override
  String toString() => '$method ($callType): $status, ${latency.inMilliseconds} ms';
}
