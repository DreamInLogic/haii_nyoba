import 'package:flutter/material.dart';

class RecentDonationCard extends StatelessWidget {
  final String date, amount, from;

  const RecentDonationCard({
    super.key,
    required this.date,
    required this.amount,
    required this.from,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, 
      constraints: const BoxConstraints(
        minHeight: 90, 
      ),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            "From: $from",
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
