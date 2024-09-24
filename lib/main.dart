import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapi/views/login_page.dart';
import 'package:testapi/views/register_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
