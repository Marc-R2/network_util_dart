import 'package:network_util/ping/ping.dart';

/// Gets no Ping - it is just to fool the DartDevtool
Ping getPing(String ip, int port) =>
    throw UnsupportedError('Ping is not supported on your platform');
