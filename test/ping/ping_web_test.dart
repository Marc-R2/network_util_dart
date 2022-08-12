@TestOn('chrome')

import 'dart:html';

import 'package:http/http.dart' as http;

import 'package:network_util/network_util.dart';
import 'package:test/test.dart';

void main() {
  group('hybrid testing', () {
    test('connect Websocket', () async {
      // Each spawnHybrid function returns a StreamChannel that communicates with
      // the hybrid isolate. You can close this channel to kill the isolate.
      final channel = spawnHybridUri('../web_socket_server.dart');

      // Get the port for the WebSocket server from the hybrid isolate.
      final port = await channel.stream.first;

      final socket = WebSocket('ws://localhost:$port');
      final message = await socket.onMessage.first;
      expect(message.data, equals('hello!'));
    });

    test('ping', () async {
      //
    });
  });
}