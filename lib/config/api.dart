class Api {
  static const String baseUrl = "http://192.168.0.104/flutter_api";

  static Uri login(String email, String password) {
    return Uri.parse(
      "$baseUrl/login.php",
    ).replace(queryParameters: {"email": email, "password": password});
  }

  static Uri staffLogin(String email, String password) {
    return Uri.parse(
      "$baseUrl/staff_login.php",
    ).replace(queryParameters: {"email": email, "password": password});
  }

  static Uri getNotifications() {
    return Uri.parse("$baseUrl/get_notifications.php");
  }

  static Uri readPersonalNotifications(String userId) {
    return Uri.parse(
      "$baseUrl/read_personal_notifications.php",
    ).replace(queryParameters: {"user_id": userId});
  }

  static Uri myApplications(String userEmail) {
    return Uri.parse(
      "$baseUrl/my_applications.php",
    ).replace(queryParameters: {"userEmail": userEmail});
  }

  static Uri readTournaments() {
    return Uri.parse("$baseUrl/read_tournament.php");
  }

  static Uri readApplications() {
    return Uri.parse("$baseUrl/read_applications.php");
  }

  static Uri respondApplication(String id, String status) {
    return Uri.parse(
      "$baseUrl/respond_application.php",
    ).replace(queryParameters: {"id": id, "status": status});
  }

  static Uri sendNotification(String userId, String message) {
    return Uri.parse(
      "$baseUrl/send_notification.php",
    ).replace(queryParameters: {"user_id": userId, "message": message});
  }

  static Uri applyTournament() {
    return Uri.parse("$baseUrl/apply_tournament.php");
  }

  static Uri createUser() {
    return Uri.parse("$baseUrl/create.php");
  }
}
