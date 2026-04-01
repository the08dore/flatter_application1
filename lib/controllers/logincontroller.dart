import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;
  // FIX: Track loading state to prevent double-taps
  var isLoading = false.obs;

  Future<bool> login(String email, String password) async {
    // FIX: Trim whitespace so accidental spaces don't cause login failures
    email = email.trim();
    password = password.trim();

    // FIX: Basic client-side validation before hitting the server
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty');
      return false;
    }

    isLoading.value = true;

    try {
      var url = Uri.parse("http://10.0.2.2/flutter_api/login.php");

      var response = await http.post(
        url,
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["code"] == 1;
      } else {
        return false;
      }
    } catch (e) {
      // FIX: Catch network errors (e.g. server offline) instead of crashing
      Get.snackbar(
        'Network Error',
        'Could not reach server. Check your connection.',
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
