import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 70,
            child: ElevatedButton.icon(
              onPressed: () {
                Provider.of<AppDataProvider>(context, listen: false)
                    .navigateToTab(1); 
              },
              icon: const Icon(Icons.volunteer_activism, size: 28, color: Colors.white),
              label: const Text(
                "Give",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C7A5A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 70,
            child: ElevatedButton.icon(
              onPressed: () {
                Provider.of<AppDataProvider>(context, listen: false)
                    .navigateToTab(2); 
              },
              icon: const Icon(Icons.handshake, size: 28, color: Color(0xFFB68B2D)),
              label: const Text(
                "Request",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF6EED2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
