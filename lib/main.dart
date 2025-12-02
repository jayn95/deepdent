import 'package:flutter/material.dart';
import 'screens/splashscreen.dart';

void main() {
  runApp(const GingiPerioApp());
}

class GingiPerioApp extends StatelessWidget {
  const GingiPerioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeepDent',
      debugShowCheckedModeBanner: false,

      // Custom ThemeData
      theme: ThemeData(
        fontFamily: 'InterTight', // ← default font for the whole app
        primaryColor: const Color(0xFF532B88),
        scaffoldBackgroundColor: const Color(0xFFF4EFFA),

        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF2F184B)),
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xFF2F184B),
          ),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF532B88),
          centerTitle: false,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'InterTight',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Color(0xFFF4EFFA),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9B72CF), // default button color
            foregroundColor: Colors.white, // default text/icon color
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      home: const SplashScreen(),
    );
  }
}
