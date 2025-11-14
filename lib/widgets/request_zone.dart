import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/app_data.dart';

class RequestZone extends StatefulWidget {
  const RequestZone({Key? key}) : super(key: key);

  @override
  State<RequestZone> createState() => _RequestZoneState();
}

class _RequestZoneState extends State<RequestZone> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Request",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey.shade800)),
          const SizedBox(height: 12),

          TextField(
            controller: controller,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: "Request short help here...",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  context.read<AppDataProvider>().addRequest(controller.text);
                  controller.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Request Sent")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C7A5A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Request", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
