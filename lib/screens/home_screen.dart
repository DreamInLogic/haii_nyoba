import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';
import '../widgets/balance_card.dart';
import '../widgets/action_buttons.dart';
import '../widgets/recent_donation_card.dart';
import '../widgets/request_zone.dart';
import '../widgets/transparency_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
            children: [
                const Icon(Icons.handshake, color: Color(0xFF4C7A5A), size: 28),
                const SizedBox(width: 8),
                const Text(
                "OpenHelp",
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4C7A5A),
                ),
                ),
            ],
            ),
            const SizedBox(height: 16),

            const Text(
            "Home",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
            ),
            ),
            const SizedBox(height: 16),

            const BalanceCard(),
            const SizedBox(height: 12),

            const ActionButtons(),
            const SizedBox(height: 22),

            const Text(
            "Recent Donations",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),

            ...context.watch<AppDataProvider>().donations.take(3).map(
            (d) => RecentDonationCard(
                date: d.date,
                amount: d.amount,
                from: d.from,
            ),
            ),

            const SizedBox(height: 20),

            const RequestZone(),
            const SizedBox(height: 22),

            const TransparencySection(),
          ],
        ),
      ),
    );
  }
}
