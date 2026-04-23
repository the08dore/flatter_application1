import 'package:get/get.dart';

class UserController extends GetxController {
  var userId = ''.obs;
  var firstname = ''.obs;
  var lastname = ''.obs;
  var email = ''.obs;

  void setUser(Map<String, dynamic> userDetails) {
    // FIX: use .value = instead of .obs when assigning (not declaring)
    userId.value = userDetails['id'].toString();
    firstname.value = userDetails['firstname'] ?? '';
    lastname.value = userDetails['lastname'] ?? '';
    email.value = userDetails['email'] ?? '';
  }

  void clearUser() {
    userId.value = '';
    firstname.value = '';
    lastname.value = '';
    email.value = '';
  }

  String get fullName => '${firstname.value} ${lastname.value}'.trim();
}
