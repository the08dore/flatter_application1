import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  var isLoading = false.obs;

  Future<bool> login(String email, String password) async {
    email = email.trim();
    password = password.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty');
      return false;
    }

    isLoading.value = true;

    try {
      // FIX: Changed to GET to match $_GET in login.php
      // FIX: Changed IP from 10.0.2.2 (emulator) to your physical phone IP
      var url = Uri.parse(
        "http://192.168.44.8/flutter_api/login.php?email=$email&password=$password",
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["code"] == 1;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar('Network Error', 'Could not reach server: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
