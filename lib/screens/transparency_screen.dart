import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';

class TransparencyScreen extends StatelessWidget {
  const TransparencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppDataProvider>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Fund Transparency",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text("“Trust is built through honesty and clarity.”",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Color(0xFFE9F3EB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "Total Balance: Rp ${app.balance.toStringAsFixed(0)}",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4C7A5A)),
              ),
            ),

            const SizedBox(height: 24),
            const Text("Donation History",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            ...app.donations.map((d) => Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: const Icon(Icons.arrow_upward, color: Color(0xFF4C7A5A)),
                title: Text(d.amount),
                subtitle: Text("${d.date} • ${d.from}"),
              ),
            )),

            const SizedBox(height: 24),
            const Text("Help Requests",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            ...app.requests.map((r) => Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: const Icon(Icons.people, color: Color(0xFFB68B2D)),
                title: Text(r),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
