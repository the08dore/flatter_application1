import 'dart:convert';
import 'package:get/get.dart';
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
      final response = await http.get(
        Uri.parse("http://192.168.44.14/flutter_api/get_notifications.php"),
      );
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
    return "http://192.168.44.14/flutter_api/" +
        cleanPath.split('/').map((seg) => Uri.encodeComponent(seg)).join('/');
  }
}
