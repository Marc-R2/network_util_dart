part of '../network_util.dart';

/// Helpers to search and ping for devices in network
class NetworkDevicePing {
  /// searches for devices in the current network on a port range
  ///
  /// [port] to [maxPort]
  static Future<List<NetworkDevice>> checkForSubnetPortRange(
    String subnet,
    int port, [
    int? maxPort,
  ]) async {
    var devices = <NetworkDevice>[];
    Message.log(
      title: 'Checking Port',
      text: '$port',
      klasse: 'NetworkDevicePing',
      sourceFunction: 'checkForSubnetPortRange',
    );
    devices += await _checkForSubnet(subnet, port);
    if (maxPort != null && port < maxPort) {
      devices += await checkForSubnetPortRange(subnet, port + 1, maxPort);
    }
    //print("devices: ${devices.length}");
    return devices;
  }

  /// searches for devices on a port range with one ip address
  ///
  /// [port] to [maxPort] on [ips]
  static Future<List<NetworkDevice>> checkForPortRange(
    List<String> ips,
    int port, [
    int? maxPort,
  ]) async {
    final checks = <Future<NetworkDevice>>[];
    for (final ip in ips) {
      for (var i = port; i < (maxPort ?? port + 100); ++i) {
        checks.add(_checkConnection(ip, i));
      }
    }

    final devices = <NetworkDevice>[];
    await Future.forEach<Future<NetworkDevice>>(checks, (_com) async {
      final com = await _com;
      if (com.exists) devices.add(com);
    });
    Message.log(
      title: 'Checking Port',
      text: '$port -> $maxPort => Found ${devices.map((e) => e.address)}',
      klasse: 'NetworkDevicePing',
      sourceFunction: 'checkForPortRange',
    );
    return devices;
  }

  /// searches for devices in a [subnet] with [port]
  static Future<List<NetworkDevice>> _checkForSubnet(
    String subnet,
    int port,
  ) async {
    final checks = <Future<NetworkDevice>>[];
    for (var i = 0; i < 256; ++i) {
      checks.add(_checkConnection('$subnet.$i', port));
    }
    final devices = <NetworkDevice>[];
    await Future.forEach<Future<NetworkDevice>>(checks, (_com) async {
      final com = await _com;
      if (com.exists) devices.add(com);
    });
    return devices;
  }

  /// Pings a network address
  static Future<NetworkDevice> _checkConnection(String ip, int port) async {
    if (await Ping(ip, port).ping()) return NetworkDevice(ip, port);
    return NetworkDevice(ip, port, exists: false);
  }
}
