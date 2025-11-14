import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/donation.dart';

class AppDataProvider extends ChangeNotifier {
  double balance = 1500000;
  int trustPoints = 0;

  int selectedTab = 0;

  void navigateToTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  final Map<String, String> _users = {};
  String? currentUser;

  List<Donation> donations = [
    Donation(date: "Jun 9, 2024", amount: "Rp 50,000", from: "Anonymous"),
    Donation(date: "May 5, 2024", amount: "Rp 20,000", from: "Anonymous"),
  ];

  List<String> requests = [
    "Need help for medical bill",
    "Struggling with food needs this week",
  ];

  bool register(String email, String password) {
    if (_users.containsKey(email)) return false;
    _users[email] = password;
    return true;
  }

  bool login(String email, String password) {
    if (_users[email] == password) {
      currentUser = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  void addDonation(String amount, String from) {
    double parsed = double.tryParse(amount.replaceAll(RegExp(r'[^0-9]'), "")) ?? 0;
    balance += parsed;

    String formattedDate = DateFormat("MMM d, yyyy").format(DateTime.now());

    String formattedAmount = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
    ).format(parsed);

    donations.insert(
    0,
    Donation(date: formattedDate, amount: formattedAmount, from: from),
    );

    trustPoints += 1;
    notifyListeners();
  }

  void addRequest(String text) {
    requests.insert(0, text);
    notifyListeners();
  }
}
