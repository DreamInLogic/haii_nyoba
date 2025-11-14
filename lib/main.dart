import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/app_data.dart';
import 'screens/home_screen.dart';
import 'screens/give_screen.dart';
import 'screens/request_screen.dart';
import 'screens/transparency_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppDataProvider(),
      child: const OpenHelpApp(),
    ),
  );
}

class OpenHelpApp extends StatelessWidget {
  const OpenHelpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppDataProvider>();

    final List<Widget> screens = [
      const HomeScreen(),
      const GiveScreen(),
      const RequestScreen(),
      const TransparencyScreen(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OpenHelp",
      theme: ThemeData(
        primaryColor: const Color(0xFF4C7A5A),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C7A5A),
        ),
      ),

      home: app.currentUser == null
          ? const LoginScreen()
          : Scaffold(
              body: screens[app.selectedTab],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: app.selectedTab,
                selectedItemColor: const Color(0xFF4C7A5A),
                unselectedItemColor: Colors.black54,
                type: BottomNavigationBarType.fixed,
                onTap: (i) => app.navigateToTab(i),
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: "Give"),
                  BottomNavigationBarItem(icon: Icon(Icons.handshake), label: "Request"),
                  BottomNavigationBarItem(icon: Icon(Icons.shield), label: "Transparency"),
                ],
              ),
            ),

      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
