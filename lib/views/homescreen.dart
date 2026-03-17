import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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

                  // Drag handle
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
                          leading: const Icon(Icons.person),
                          title: const Text("Lawyers"),
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed('/lawyers');
                          },
                        ),

                        ListTile(
                          leading: const Icon(Icons.chat),
                          title: const Text("Post Question"),
                          onTap: () {
                            Navigator.pop(context);
                            Get.toNamed('/questions');
                          },
                        ),

                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text("Settings"),
                        ),

                        ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text("Notifications"),
                        ),

                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text("Logout"),
                          onTap: () {
                            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'profile') {
                Get.toNamed('/profile');
              } else if (value == 'exit') {
                Get.toNamed('/login');
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
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Colors.white,
        color: Colors.blue,
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
            setState(() {
              selectedIndex = 0;
            });
          }

          if (index == 1) {
            setState(() {
              selectedIndex = 1;
            });

            showMenu(context, "List Menu");
          }
        },
      ),
    );
  }
}
