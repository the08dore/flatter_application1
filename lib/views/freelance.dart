import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeLance extends StatefulWidget {
  const FreeLance({super.key});

  @override
  State<FreeLance> createState() => _FreeLanceState();
}

class _FreeLanceState extends State<FreeLance> {
  final List<Map<String, String>> lawyers = [
    {
      "name": "Marcel Muhehe",
      "specialty": "Criminal Law",
      "experience": "5 years",
    },
    {"name": "Wayne Misoi", "specialty": "Family Law", "experience": "8 years"},
    {
      "name": "Fredrick Mutunga",
      "specialty": "Corporate Law",
      "experience": "6 years",
    },
    {
      "name": "Sophia Daniella",
      "specialty": "Civil Law",
      "experience": "4 years",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Freelance Lawyers")),

      body: ListView.builder(
        itemCount: lawyers.length,
        itemBuilder: (context, index) {
          final lawyer = lawyers[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,

            child: ListTile(
              contentPadding: const EdgeInsets.all(12),

              leading: const CircleAvatar(
                radius: 25,
                child: Icon(Icons.person),
              ),

              title: Text(
                lawyer["name"] ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "${lawyer["specialty"] ?? ""} • ${lawyer["experience"] ?? ""}",
                ),
              ),

              trailing: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/lawyer-details', arguments: lawyer);
                },
                child: const Text("Hire"),
              ),
            ),
          );
        },
      ),
    );
  }
}
