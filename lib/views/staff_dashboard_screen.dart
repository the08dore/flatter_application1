import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StaffDashboardScreen extends StatefulWidget {
  final String staffName;
  const StaffDashboardScreen({super.key, required this.staffName});

  @override
  State<StaffDashboardScreen> createState() => _StaffDashboardScreenState();
}

class _StaffDashboardScreenState extends State<StaffDashboardScreen> {
  List<dynamic> applications = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final response = await http.get(
        Uri.parse("http://192.168.44.24/flutter_api/read_applications.php"),
      );
      final data = jsonDecode(response.body);
      if (data['code'] == 1) {
        setState(() {
          applications = data['applications'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = data['message'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Could not reach server: $e';
        isLoading = false;
      });
    }
  }

  Future<void> respond(String id, String status) async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://192.168.44.24/flutter_api/respond_application.php?id=$id&status=$status",
        ),
      );
      final data = jsonDecode(response.body);
      Get.snackbar(
        data['code'] == 1 ? 'Done' : 'Failed',
        data['message'],
        backgroundColor: data['code'] == 1 ? Colors.green : Colors.red,
        colorText: Colors.white,
      );
      if (data['code'] == 1) fetchApplications();
    } catch (e) {
      Get.snackbar('Error', 'Server error');
    }
  }

  Future<void> sendNotification(String userId, String message) async {
    try {
      final response = await http.get(
        Uri.parse(
          "http://192.168.44.24/flutter_api/send_notification.php"
          "?user_id=$userId&message=$message",
        ),
      );
      final data = jsonDecode(response.body);
      Get.snackbar(
        data['code'] == 1 ? 'Sent' : 'Failed',
        data['code'] == 1 ? 'Notification sent to user' : data['message'],
        backgroundColor: data['code'] == 1 ? Colors.green : Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Could not send notification: $e');
    }
  }

  // Show dialog to choose yes or no before sending notification
  Future<void> showNotificationDialog(String userId, String userName) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Notify $userName'),
        content: const Text('Send acceptance result to user?'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              sendNotification(userId, 'no');
            },
            icon: const Icon(Icons.close, color: Colors.red),
            label: const Text('Send No', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Navigator.pop(context);
              sendNotification(userId, 'yes');
            },
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text(
              'Send Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'declined':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.staffName}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchApplications,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed('/'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/sign_up.jpg', fit: BoxFit.cover),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: fetchApplications,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: applications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final app = applications[index];
                    final isPending = app['status'] == 'pending';
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tournament name + status badge
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    app['tournamentName'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: statusColor(
                                      app['status'],
                                    ).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    app['status'].toString().toUpperCase(),
                                    style: TextStyle(
                                      color: statusColor(app['status']),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 16),
                            // Applicant details
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text('${app['firstname']} ${app['lastname']}'),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(app['email'] ?? ''),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(app['location'] ?? ''),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.cake,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text('Age group: ${app['ageGroup']}'),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Accept / Decline row (pending only)
                            if (isPending) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () => respond(
                                        app['id'].toString(),
                                        'accepted',
                                      ),
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      label: const Text(
                                        'Accept',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () => respond(
                                        app['id'].toString(),
                                        'declined',
                                      ),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      label: const Text(
                                        'Decline',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                            // Notify button always visible
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.blue),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => showNotificationDialog(
                                  app['user_id'].toString(),
                                  '${app['firstname']} ${app['lastname']}',
                                ),
                                icon: const Icon(
                                  Icons.notifications,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                                label: const Text(
                                  'Send Notification',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
