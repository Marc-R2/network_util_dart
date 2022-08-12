// Sample from https://pub.dev/packages/test

// The library loaded by spawnHybridUri() can import any packages that your
// package depends on, including those that only work on the VM.
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:stream_channel/stream_channel.dart';

/// Once the hybrid isolate starts, it will call the special function
/// hybridMain() with a StreamChannel that's connected to the channel
/// returned spawnHybridCode().
Future<void> hybridMain(StreamChannel<dynamic> channel) async {
  // Start a WebSocket server that just sends "hello!" to its clients.
  final server = await io.serve(
    webSocketHandler((dynamic webSocket) {
      webSocket.sink.add('hello!');
      // Print the type of the webSocket.
      print(webSocket.runtimeType);
    }),
    'localhost',
    0,
  );

  // Send the port number of the WebSocket server to the browser test, so
  // it knows what to connect to.
  channel.sink.add(server.port);
}
