import 'package:api_app/home.dart';
import 'package:api_app/imageuploading/image_upload.dart';
import 'package:api_app/login_page.dart';
import 'package:api_app/servicesGetLearing.dart';
import 'package:flutter/material.dart';

void main() {
  ApiService.getUsers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Rest Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageUpload(),
    );
  }
}
