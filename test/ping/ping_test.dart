import 'package:network_util/network_util.dart';
import 'package:test/test.dart';

void main() {
  group('Ping', () {
    // Test ping
    test('ping', () async {
      // Ping google.com
      final ping = Ping('google.com', 80);
      expect(await ping.ping(), isTrue);
    });
  });
}
