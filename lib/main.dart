import 'package:flutter/material.dart';
import 'camera_code.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Native Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Native Demo'),
          backgroundColor: Colors.blue,
        ),
        body: CameraApp(),
      ),
    );
  }
}
