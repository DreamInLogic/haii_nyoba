import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:openhelp_app/data/app_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String error = "";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.handshake, color: Color(0xFF4C7A5A), size: 60),
                const SizedBox(height: 8),
                const Text(
                  "OpenHelp Login",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, fontFamily: 'Poppins', color: Color(0xFF4C7A5A)),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),

                if (error.isNotEmpty)
                  Text(error, style: const TextStyle(color: Colors.red, fontFamily: 'Poppins')),
                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4C7A5A), fixedSize: const Size(double.infinity, 48)),
                  onPressed: () {
                    final app = context.read<AppDataProvider>();
                    if (app.login(_email.text, _password.text)) {
                      Navigator.pushReplacementNamed(context, '/');
                    } else {
                      setState(() => error = "Email or password incorect");
                    }
                  },
                  child: const Text("Login", style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
                ),
                const SizedBox(height: 12),

                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text("Don't have account? Register", style: TextStyle(fontFamily: 'Poppins')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.handshake, color: Color(0xFF4C7A5A), size: 60),
                const SizedBox(height: 8),
                const Text(
                  "OpenHelp Register",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, fontFamily: 'Poppins', color: Color(0xFF4C7A5A)),
                ),
                const SizedBox(height: 30),

                TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),

                if (error.isNotEmpty)
                  Text(error, style: const TextStyle(color: Colors.red, fontFamily: 'Poppins')),
                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4C7A5A), fixedSize: const Size(double.infinity, 48)),
                  onPressed: () {
                    final app = context.read<AppDataProvider>();
                    final success = app.register(_email.text, _password.text);
                    if (success) {
                      Navigator.pop(context);
                    } else {
                      setState(() => error = "Email is already in use");
                    }
                  },
                  child: const Text("Register", style: TextStyle(fontFamily: 'Poppins', color: Colors.white)),
                ),
                const SizedBox(height: 12),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Already have an account? Login", style: TextStyle(fontFamily: 'Poppins')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
