import 'package:flutter/services.dart';

class NativeCode {
  static const platform = MethodChannel('com.example/native_demo_app');

  Future<String> getNativeString() async {
    try {
      final String result = await platform.invokeMethod('getStaticString');
      return result;
    } on PlatformException catch (e) {
      return "Failed to get native string: '${e.message}'";
    }
  }
}
