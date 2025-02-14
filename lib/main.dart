import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF1C2E4A),
          secondary: const Color.fromARGB(255, 77, 255, 130),
          tertiary: const Color(0xFF26A69A),
          background: const Color(0xFFF5F7FA),
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: const Color(0xFF1C2E4A),
          onBackground: const Color(0xFF1C2E4A),
          onSurface: const Color(0xFF34495E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C2E4A),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        chipTheme: ChipThemeData(
          selectedColor: const Color(0xFFFFB74D),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(color: Color(0xFF1C2E4A), width: 1),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
