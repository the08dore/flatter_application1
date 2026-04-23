import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_2/config/colors.dart';
import 'package:flutter_application_2/controllers/notification_controller.dart';
import 'package:flutter_application_2/controllers/user_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final NotificationController notifController =
      Get.find<NotificationController>();
  // FIX: Access the globally stored user so we can pass userId to screens
  final UserController userController = Get.find<UserController>();

  Future<void> showMenu(BuildContext context, String title) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.chat),
                          title: const Text(
                            "Request To Sign Up For Tournament",
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // FIX: Pass user profile from UserController
                            Get.toNamed(
                              '/register',
                              arguments: {
                                'name': userController.fullName,
                                'email': userController.email.value,
                                'age': '',
                              },
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text("Notifications"),
                          onTap: () {
                            Navigator.pop(context);
                            // FIX: Pass userId to notifications screen
                            Get.toNamed(
                              '/mynotifications',
                              arguments: userController.userId.value,
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text("Logout"),
                          onTap: () {
                            Navigator.pop(context);
                            userController.clearUser();
                            Get.toNamed('/');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    setState(() {
      selectedIndex = 0;
    });

    final navBarState = _bottomNavigationKey.currentState;
    navBarState?.setPage(0);
  }

  Widget buildCard(dynamic item) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                notifController.buildImageUrl(item['image']),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['message'] ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'profile') {
                Get.toNamed('/profile');
              } else if (value == 'exit') {
                userController.clearUser();
                Get.toNamed('/');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('View profile'),
              ),
              const PopupMenuItem(value: 'exit', child: Text('Log out')),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sign_up.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Obx(() {
            if (notifController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (notifController.notifications.isEmpty) {
              return const Center(
                child: Text(
                  "No notifications",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
            return ListView.builder(
              itemCount: notifController.notifications.length,
              itemBuilder: (context, index) {
                return buildCard(notifController.notifications[index]);
              },
            );
          }),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: primaryColor,
        color: secondaryColor,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: selectedIndex == 0 ? Colors.white : Colors.white70,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: selectedIndex == 1 ? Colors.white : Colors.white70,
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            setState(() => selectedIndex = 0);
          }
          if (index == 1) {
            setState(() => selectedIndex = 1);
            showMenu(context, "List Menu");
          }
        },
      ),
    );
  }
}
