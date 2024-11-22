import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _imageDate;

  Future<void> _takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageDate = DateFormat('yyyy-MM-dd – kk:mm').format(
          File(pickedFile.path).lastModifiedSync(),
        );
      }
    });
  }

  void _showDateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(20),
          title: Column(
            children: [
              Image.asset(
                'assets/Robot.webp',
                height: 50,
                width: 50,
              ),
              SizedBox(height: 10),
              Text(
                'Native data:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            _imageDate != null ? _imageDate! : 'No date available',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center, // Центрування тексту
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрити діалог
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: _image == null
              ? Text('No image selected.')
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(
                _image!,
                height: 400,
                width: 400,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        Positioned(
          top: 20, // Відступ від верхнього краю
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: ElevatedButton(
              onPressed: _showDateDialog,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Date Now'),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _takePicture,
            tooltip: 'Take Picture',
            child: Icon(Icons.camera),
          ),
        ),
      ],
    );
  }
}
