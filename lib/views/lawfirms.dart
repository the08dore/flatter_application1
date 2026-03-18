import 'package:flutter/material.dart';

class LawFirms extends StatelessWidget {
  const LawFirms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SimpleLawFirmCard(
            name: 'Kiptoo & Associates',
            tag: 'Corporate • Commercial',
            color: Colors.blueGrey,
          ),
          SizedBox(height: 12),
          SimpleLawFirmCard(
            name: 'Wanjiku Advocates',
            tag: 'Family • Land • Probate',
            color: Colors.brown,
          ),
        ],
      ),
    );
  }
}

class SimpleLawFirmCard extends StatelessWidget {
  final String name;
  final String tag;
  final Color color;

  const SimpleLawFirmCard({
    super.key,
    required this.name,
    required this.tag,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(Icons.balance, color: color),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(tag),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
