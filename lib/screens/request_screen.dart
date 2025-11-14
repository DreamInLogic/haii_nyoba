// lib/screens/request_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _reqController = TextEditingController();
  String _methodType = 'Bank'; // Bank or E-Wallet
  String? _selectedProvider;

  // For request: user-provided account/phone input
  final _accountController = TextEditingController();

  // picked image file
  File? _pickedImage;

  final List<String> _banks = ['BRI', 'BNI', 'Mandiri', 'BCA'];
  final List<String> _ewallets = ['DANA', 'ShopeePay', 'GoPay'];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? xfile = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1200);
    if (xfile == null) return;
    setState(() {
      _pickedImage = File(xfile.path);
    });
  }

  @override
  void dispose() {
    _reqController.dispose();
    _accountController.dispose();
    super.dispose();
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
              const Text("Request Help", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text(
                "“Never hesitate to ask for help. We grow by lifting each other.”",
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6EED2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Explain your situation clearly. Our community is here to support.",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: _reqController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Describe your situation...",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              const SizedBox(height: 16),

              // Method type toggle
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('Bank'),
                    selected: _methodType == 'Bank',
                    onSelected: (v) => setState(() {
                      _methodType = 'Bank';
                      _selectedProvider = null;
                      _accountController.text = '';
                    }),
                    selectedColor: const Color(0xFFF6EED2),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('E-Wallet'),
                    selected: _methodType == 'E-Wallet',
                    onSelected: (v) => setState(() {
                      _methodType = 'E-Wallet';
                      _selectedProvider = null;
                      _accountController.text = '';
                    }),
                    selectedColor: const Color(0xFFE9F3EB),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Provider dropdown
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
                        .map((p) => DropdownMenuItem(
                              value: p,
                              child: Row(children: [
                                // try asset icon
                                Image.asset(
                                  'assets/icons/${p.toLowerCase()}.png',
                                  width: 28,
                                  height: 28,
                                  errorBuilder: (_, __, ___) => Icon(_methodType == 'Bank' ? Icons.account_balance : Icons.phone_iphone, size: 20),
                                ),
                                const SizedBox(width: 10),
                                Text(p),
                              ]),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedProvider = v),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Account / phone input
              TextField(
                controller: _accountController,
                keyboardType: _methodType == 'Bank' ? TextInputType.number : TextInputType.phone,
                decoration: _inputStyle(_methodType == 'Bank' ? "Account number" : "Phone number for e-wallet"),
              ),

              const SizedBox(height: 12),

              // Proof upload
              Text("Proof / Receipt (optional)", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade800)),
              const SizedBox(height: 8),

              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo_library, color: Colors.white),
                    label: const Text(
                      "Upload Proof",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C7A5A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (_pickedImage != null)
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(_pickedImage!, width: 86, height: 86, fit: BoxFit.cover),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // basic validation
                    if (_reqController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please describe your situation")));
                      return;
                    }
                    // For request we'll keep addRequest simple
                    final combined = _reqController.text.trim() +
                        (_selectedProvider != null ? " [${_selectedProvider!} ${_accountController.text}]" : "");
                    context.read<AppDataProvider>().addRequest(combined);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Submitted")));
                    _reqController.clear();
                    _accountController.clear();
                    setState(() => _pickedImage = null);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB68B2D),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Submit Request", style: TextStyle(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 20),
              const Text("Recent Requests", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),

              ...app.requests.take(3).map((r) => ListTile(
                    leading: const Icon(Icons.support, color: Color(0xFFB68B2D)),
                    title: Text(r),
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
}
