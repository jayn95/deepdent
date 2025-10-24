import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GingiPerioApp());
}

class GingiPerioApp extends StatelessWidget {
  const GingiPerioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gingi-Perio Detection',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
