import 'package:filio_test/method_channel_helper.dart';
import 'package:flutter/widgets.dart';

class AppLifecycle extends WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      await MethodChannelHelper.incrementCounter();
    }
  }
}
