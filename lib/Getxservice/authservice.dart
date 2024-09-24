import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testapi/constants/constants.dart';

class AuthService {

  // Fetch available roles
  Future<List<Map<String, dynamic>>> fetchRoles() async {
    final url = Uri.parse('$baseUrl/roles');  // Adjust this if your endpoint differs

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List roles = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(roles);  // Cast response into List of Maps
      } else {
        print('Failed to fetch roles: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error fetching roles: $e');
      return [];
    }
  }

  // Register user without image upload
  Future<Map<String, dynamic>?> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required int roleId,
    required String password,
    Map<String, dynamic>? social,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    final body = jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'role_id': roleId.toString(),
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body); // Return user data and token
      } else {
        print('Failed to register: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error registering: $e');
      return null;
    }
  }

  // Login user
  Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Return user data and token
      } else {
        print('Failed to login: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }
}
