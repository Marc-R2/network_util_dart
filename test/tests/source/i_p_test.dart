// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'package:network_util/ip.dart';
import 'package:test_builder/test_builder.dart';
import '../../.testGen/source/i_p.test_gen.dart';

void main() {
  IPTest();
}

class IPTest extends IPTestTop {
  @override
  void constructorTest() {}

  @override
  void constructor_Test() {}

  @override
  void publicIPTestGetter() {
    test('getPublicIP', () async {
      final ip = await IP().publicIP;
      expect(ip, isNotNull);
      print('Public IP: $ip');
    });
  }

  @override
  void publicIPv4TestGetter() {}

  @override
  void localLocalIPsTest() {}

  @override
  void localIPTestGetter() {
    test('localIP', () async {
      final ip = await IP().localIP;
      expect(ip, isNotNull);
      print('Local IP: $ip');
    });
  }

  @override
  void filterLocalByTypeTest() {}

  @override
  void localIPv4TestGetter() {}

  @override
  void localIPv6TestGetter() {}
}
