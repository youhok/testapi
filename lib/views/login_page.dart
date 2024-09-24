import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapi/controller/authcontroller.dart';
import 'package:testapi/views/register_page.dart'; // Assuming you have a RegisterPage

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Email input
            TextField(
              onChanged: (value) => authController.email.value = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Password input
            TextField(
              obscureText: true,
              onChanged: (value) => authController.password.value = value,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20), // Space between input fields and buttons
            // Login button
            ElevatedButton(
              onPressed: () => authController.login(),
              child: Text('Login'),
            ),
            SizedBox(height: 10), // Space between login and register button
            // Register button
            ElevatedButton(
              onPressed: () => Get.to(() => RegisterPage()), // Navigate to RegisterPage
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
