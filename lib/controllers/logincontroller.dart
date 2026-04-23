import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_2/config/api.dart';

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
      var response = await http.get(Api.login(email, password));

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
