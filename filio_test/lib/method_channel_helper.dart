import 'package:flutter/services.dart';

class MethodChannelHelper {
  static const String CHANNEL_NAME = "increment_counter";

  static Future<void> incrementCounter() async {
    try {
      final result =
          await const MethodChannel(CHANNEL_NAME).invokeMethod('increment');
      print("Counter incremented from Swift: $result");
    } on PlatformException catch (e) {
      print("Error calling Swift method: ${e.message}");
    }
  }
}
