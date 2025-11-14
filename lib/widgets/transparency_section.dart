import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';

class TransparencySection extends StatelessWidget {
  const TransparencySection({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppDataProvider>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Transparency & Trust Points",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          const Text("Total Donations", style: TextStyle(fontSize: 14)),
          const SizedBox(height: 4),

          Text(
            "Rp ${app.balance.toStringAsFixed(0)}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),
          const Text("Trust Points", style: TextStyle(fontSize: 14)),
          Text("+${app.trustPoints} points", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 12),
          const Text("Last Donation", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),

          if (app.donations.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(app.donations.first.date),
                const Text("+1 donation"),
              ],
            )
        ],
      ),
    );
  }
}
