
import 'package:network_util/ping/ping_stub.dart'
    if (dart.library.io) 'package:network_util/ping/ping_io.dart'
    if (dart.library.html) 'package:network_util/ping/ping_web.dart';

/// Abstraction for Ping to work on io and web
abstract class Ping {
  /// Creates a Ping
  factory Ping(String ip, int port) => getPing(ip, port);

  /// IP of the pinged device
  late final String ip;

  /// Port of the pinged device
  late final int port;

  /// Time it took to get a connection in microseconds
  late int? responseTime;

  /// If the device exists
  bool exists = false;

  /// Executes a ping
  Future<bool> ping();
}
