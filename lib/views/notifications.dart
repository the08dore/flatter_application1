import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/api.dart';
import 'package:http/http.dart' as http;

class PersonalNotificationsScreen extends StatefulWidget {
  final String userId;
  const PersonalNotificationsScreen({super.key, required this.userId});

  @override
  State<PersonalNotificationsScreen> createState() =>
      _PersonalNotificationsScreenState();
}

class _PersonalNotificationsScreenState
    extends State<PersonalNotificationsScreen> {
  List<dynamic> notifications = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      final response = await http.get(
        Api.readPersonalNotifications(widget.userId),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['code'] == 1) {
          setState(() {
            notifications = data['notifications'];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = data['message'];
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error. Please try again.';
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

  // Format the created_at timestamp nicely
  String formatDate(String rawDate) {
    try {
      final dt = DateTime.parse(rawDate);
      return "${dt.day}/${dt.month}/${dt.year}  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notifications'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
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
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: fetchNotifications,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    final isYes = notif['message'] == 'yes';
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: (isYes ? Colors.green : Colors.red)
                              .withOpacity(0.15),
                          child: Icon(
                            isYes ? Icons.check_circle : Icons.cancel,
                            color: isYes ? Colors.green : Colors.red,
                          ),
                        ),
                        title: Text(
                          isYes
                              ? 'Application Accepted'
                              : 'Application Declined',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isYes ? Colors.green : Colors.red,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              isYes
                                  ? 'Congratulations! You have been accepted.'
                                  : 'Unfortunately your application was not successful.',
                              style: const TextStyle(fontSize: 13),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formatDate(notif['created_at']),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
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
