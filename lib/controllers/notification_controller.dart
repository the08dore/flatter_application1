import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_application_2/config/api.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  var notifications = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading(true);
      final response = await http.get(Api.getNotifications());
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"]) {
          notifications.assignAll(data["data"]);
        }
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  String buildImageUrl(dynamic imagePath) {
    final rawPath = imagePath?.toString() ?? '';
    final cleanPath = rawPath.startsWith('/') ? rawPath.substring(1) : rawPath;
    return "${Api.baseUrl}/" +
        cleanPath.split('/').map((seg) => Uri.encodeComponent(seg)).join('/');
  }
}
