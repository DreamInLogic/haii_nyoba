import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';

class GiveScreen extends StatefulWidget {
  const GiveScreen({super.key});

  @override
  State<GiveScreen> createState() => _GiveScreenState();
}

class _GiveScreenState extends State<GiveScreen> {
  final _amountController = TextEditingController();
  final _nameController = TextEditingController(text: "Anonymous");
  final _accountController = TextEditingController(); 
  final _phoneController = TextEditingController(); 

  String _methodType = 'Bank'; // 'Bank' or 'E-Wallet'
  String? _selectedProvider;

  final List<String> _banks = ['BRI', 'BNI', 'Mandiri', 'BCA'];
  final List<String> _ewallets = ['DANA', 'ShopeePay', 'GoPay'];

  @override
  void dispose() {
    _amountController.dispose();
    _nameController.dispose();
    _accountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _isBank(String p) => _banks.contains(p);

  Widget _providerTile(String provider) {
    final assetPath = 'assets/icons/${provider.toLowerCase()}.png';
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 28,
          height: 28,
          errorBuilder: (_, __, ___) => Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            child: Icon(
              _isBank(provider) ? Icons.account_balance : Icons.phone_iphone,
              size: 20,
              color: _isBank(provider) ? const Color(0xFF4C7A5A) : const Color(0xFFB68B2D),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(provider, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppDataProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Give Help", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text(
                "“A small act of kindness can create a big impact.”",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54),
              ),
              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F3EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Current Community Balance: Rp ${app.balance.toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF4C7A5A)),
                ),
              ),
              const SizedBox(height: 18),

              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: _inputStyle("Donation Amount (Rp)"),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: _nameController,
                decoration: _inputStyle("Your Name (or Anonymous)"),
              ),
              const SizedBox(height: 18),

              // Toggle Bank / E-Wallet
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Bank'),
                    selected: _methodType == 'Bank',
                    onSelected: (v) => setState(() {
                      _methodType = 'Bank';
                      _selectedProvider = null;
                    }),
                    selectedColor: const Color(0xFFE9F3EB),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('E-Wallet'),
                    selected: _methodType == 'E-Wallet',
                    onSelected: (v) => setState(() {
                      _methodType = 'E-Wallet';
                      _selectedProvider = null;
                    }),
                    selectedColor: const Color(0xFFF6EED2),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dropdown provider
              InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(_methodType == 'Bank' ? 'Select bank' : 'Select e-wallet'),
                    value: _selectedProvider,
                    items: (_methodType == 'Bank' ? _banks : _ewallets)
                        .map((p) => DropdownMenuItem(value: p, child: _providerTile(p)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedProvider = v),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              if (_selectedProvider != null && _isBank(_selectedProvider!)) ...[
                const Text("Bank Account Number", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: _accountController,
                  keyboardType: TextInputType.number,
                  decoration: _inputStyle("Enter bank account number"),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Transfer the donation to the account above and press Donate when done.",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ] else if (_selectedProvider != null && !_isBank(_selectedProvider!)) ...[
                const Text("Phone Number", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: _inputStyle("Phone number for top-up (e.g. 0812xxxx)"),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Send donation via the e-wallet app to the phone number above and press Donate when done.",
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
              const SizedBox(height: 18),

              // Tombol donate
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final amt = _amountController.text.trim();
                    if (amt.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter amount")));
                      return;
                    }
                    context.read<AppDataProvider>().addDonation("Rp $amt", _nameController.text);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Donation Successful!")));
                    _amountController.clear();
                    _accountController.clear();
                    _phoneController.clear();
                  },
                  style: _btnStyle(),
                  child: const Text("Donate"),
                ),
              ),
              const SizedBox(height: 26),

              const Text("Recent Donations", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),

              ...app.donations.take(3).map((d) => ListTile(
                    leading: const Icon(Icons.favorite, color: Color(0xFF4C7A5A)),
                    title: Text(d.amount),
                    subtitle: Text("${d.date} — ${d.from}"),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );

  ButtonStyle _btnStyle() => ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4C7A5A),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      );
}
