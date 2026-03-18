import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Lawyers extends StatefulWidget {
  const Lawyers({super.key});

  @override
  State<Lawyers> createState() => _LawyersState();
}

class _LawyersState extends State<Lawyers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Law Firm Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.business, size: 40),
                title: const Text(
                  "Law Firms",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Connect with registered law firms"),
                onTap: () {
                  Get.toNamed('/lawfirms');
                },
              ),
            ),

            const SizedBox(height: 20),

            // Freelance Lawyers Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.person, size: 40),
                title: const Text(
                  "Freelance Lawyers",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Hire independent legal experts"),
                onTap: () {
                  Get.toNamed('/freelance');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
