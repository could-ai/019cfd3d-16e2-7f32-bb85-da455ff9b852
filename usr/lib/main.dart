import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const DailySyncApp());
}

class DailySyncApp extends StatelessWidget {
  const DailySyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailySync AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Modern Indigo
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto', // Default clean font
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system, // Supports modern dark mode trend
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
