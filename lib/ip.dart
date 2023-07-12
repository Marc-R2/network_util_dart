import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:log_message/logger.dart';
import 'package:test_builder_annotation/test_builder_annotation.dart';

@TestGen()
class IP with Logging {
  factory IP() => _instance;

  IP._();

  static final IP _instance = IP._();

  Future<String> get publicIP => Ipify.ipv64();

  Future<String> get publicIPv4 => Ipify.ipv4();

  Future<List<InternetAddress>> localLocalIPs() async {
    final interfaces = await NetworkInterface.list();
    final addresses = <InternetAddress>[];
    for (final interface in interfaces) {
      addresses.addAll(interface.addresses);
    }
    return addresses;
  }

  Future<String> get localIP async => (await localLocalIPs()).first.address;

  Future<Iterable<InternetAddress>> filterLocalByType(
      InternetAddressType type) async {
    final ips = await localLocalIPs();
    return ips.where((element) => element.type == type);
  }

  Future<String?> get localIPv4 async {
    final ips = await filterLocalByType(InternetAddressType.IPv4);
    return ips.isNotEmpty ? ips.first.address : null;
  }

  Future<String?> get localIPv6 async {
    final ips = await filterLocalByType(InternetAddressType.IPv6);
    return ips.isNotEmpty ? ips.first.address : null;
  }
}
