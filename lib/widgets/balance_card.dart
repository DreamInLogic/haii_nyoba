import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppDataProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F3EB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Balance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(
            "Rp ${app.balance.toStringAsFixed(0)}",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
