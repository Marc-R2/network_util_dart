part of '../network_ping.dart';

/// Theroratical device in network
class NetworkDevice {
  ///Creats a NetworkDevice from it's [ip] and [port]
  const NetworkDevice(this.ip, this.port, {this.exists = true});

  /// If the Device exists
  final bool exists;

  /// IP of the Device
  final String ip;

  /// Port of the Device
  final int port;

  /// Returns the [ip] and [port] as a String
  String get address => '$ip:$port';

  /// Returns a [NetworkDevice] with the same [ip] and [port]
  /// and changed [exists]
  NetworkDevice asExists({bool? exist}) => NetworkDevice(
    ip,
    port,
    exists: exist ?? !exists,
  );

  /// Check if the device is reachable and returns a new [NetworkDevice]
  Future<NetworkDevice> checkConnection() async {
    if (await Ping(ip, port).ping()) return NetworkDevice(ip, port);
    return NetworkDevice(ip, port, exists: false);
  }
}
