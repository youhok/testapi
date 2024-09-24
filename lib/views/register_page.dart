import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testapi/controller/authcontroller.dart';

class RegisterPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // First name input
              TextField(
                onChanged: (value) => authController.firstName.value = value,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              // Last name input
              TextField(
                onChanged: (value) => authController.lastName.value = value,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              // Phone number input
              TextField(
                onChanged: (value) => authController.phoneNumber.value = value,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
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
              // Role selection dropdown
              Obx(() => DropdownButton<int>(
                value: authController.roleId.value == 0 ? null : authController.roleId.value,
                hint: Text('Select Role'),
                items: authController.roles.map((role) {
                  return DropdownMenuItem<int>(
                    value: role['id'],
                    child: Text(role['name']),
                  );
                }).toList(),
                onChanged: (value) => authController.roleId.value = value!,
              )),
              // Register button
              ElevatedButton(
                onPressed: () => authController.register(),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
