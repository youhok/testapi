import 'package:get/get.dart';
import 'package:testapi/Getxservice/authservice.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // Form fields
  var firstName = ''.obs;
  var lastName = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var roleId = 0.obs;  // This will be the selected role ID
  var roles = <Map<String, dynamic>>[].obs;  // List of roles from the server

  // Fetch roles when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    fetchRoles();  // Fetch roles on controller initialization
  }

  // Fetch roles with error handling
  Future<void> fetchRoles() async {
    try {
      final result = await _authService.fetchRoles();
      roles.assignAll(result.map((role) => {'id': role['id'], 'name': role['name']}).toList());
    } catch (e) {
      Get.snackbar('Error', 'Failed to load roles');
      print('Error fetching roles: $e');
    }
  }

  // Registration method with validation
  Future<void> register() async {
    if (firstName.isEmpty || lastName.isEmpty || phoneNumber.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all required fields');
      return;
    }

    if (roleId.value == 0) {
      Get.snackbar('Error', 'Please select a role');
      return;
    }

    final result = await _authService.register(
      firstName: firstName.value,
      lastName: lastName.value,
      phoneNumber: phoneNumber.value,
      email: email.value,
      roleId: roleId.value,
      password: password.value,
    );

    if (result != null) {
      Get.snackbar('Success', 'Registration successful');
      clearForm();  // Clear form fields after successful registration
    } else {
      Get.snackbar('Error', 'Registration failed');
    }
  }

  // Login method
  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter your email and password');
      return;
    }

    final result = await _authService.login(
      email: email.value,
      password: password.value,
    );

    if (result != null) {
      Get.snackbar('Success', 'Login successful');
      // Navigate to home or other screen
    } else {
      Get.snackbar('Error', 'Login failed');
    }
  }

  // Method to clear form fields after successful registration
  void clearForm() {
    firstName.value = '';
    lastName.value = '';
    phoneNumber.value = '';
    email.value = '';
    password.value = '';
    roleId.value = 0;
  }
}
