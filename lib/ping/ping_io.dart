import 'dart:io';

import 'package:logger/logger.dart';
import 'package:network_util/ping/ping.dart';


/// Ping for use in IO
class PingIO implements Ping {
  /// Creates a Ping for use on IO
  PingIO(this.ip, this.port);

  @override
  bool exists = false;

  @override
  String ip;

  @override
  int port;

  @override
  int? responseTime;

  @override
  Future<bool> ping() async {
    final start = DateTime.now();
    Message.trace(
      title: 'Ping Device',
      text: '$ip:$port',
      klasse: this,
      function: 'ping',
      tags: ['$ip:$port'],
    );
    await Socket.connect(ip, port, timeout: const Duration(seconds: 5))
        .then((socket) {
      Message.log(
        title: 'Ping Device Success',
        text: 'Found: $ip:$port',
        klasse: this,
        function: 'ping',
        tags: ['$ip:$port'],
      );
      exists = true;
      socket.destroy();
    }).onError((error, stackTrace) {});
    responseTime =
        DateTime.now().microsecondsSinceEpoch - start.microsecondsSinceEpoch;
    return exists;
  }
}

/// Gets a PingIO
Ping getPing(String ip, int port) => PingIO(ip, port);
