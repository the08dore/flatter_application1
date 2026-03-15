import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
                      children: const [
                        ListTile(
                          leading: Icon(Icons.dashboard),
                          title: Text("Dashboard"),
                        ),

                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Profile"),
                        ),

                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("Settings"),
                        ),

                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text("Notifications"),
                        ),

                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("Logout"),
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
      body: const Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
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

          Icon(
            Icons.person,
            size: 30,
            color: selectedIndex == 2 ? Colors.white : Colors.white70,
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

          if (index == 2) {
            setState(() {
              selectedIndex = 2;
            });

            showMenu(context, "Profile Menu");
          }
        },
      ),
    );
  }
}
