import 'package:http/http.dart' as http;
import 'package:network_util/ping/ping.dart';

/// Ping for use in IO
class PingWeb implements Ping {
  /// Creates a Ping for use on the Web
  PingWeb(this.ip, this.port);

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
    try {
      await http.get(Uri.parse('https://$ip:$port/'));
      responseTime =
          DateTime.now().microsecondsSinceEpoch - start.microsecondsSinceEpoch;
      return exists = true;
    } catch (e) {
      responseTime =
          DateTime.now().microsecondsSinceEpoch - start.microsecondsSinceEpoch;
      return exists = '$e' != 'XMLHttpRequest error.';
    }
  }
}

/// Gets a PingWeb
Ping getPing(String ip, int port) => PingWeb(ip, port);
