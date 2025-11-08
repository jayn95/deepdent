import 'package:flutter/material.dart';
import '../screens/disease_selection_screen.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF), // White at top
              Color(0xFFDFB2FF), // Very light lavender at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Replace placeholder with actual logo image
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: const DecorationImage(
                      image: AssetImage('lib/assets/name_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text(
                  "Early gum disease detection made easy, right on your phone.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1C21), // Primary text
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                // CustomButton with theme
                Theme(
                  data: Theme.of(context).copyWith(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAF76FA),
                        foregroundColor: const Color(0xFFFFFFFF),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                  child: CustomButton(
                    text: "Get started",
                    icon: Icons.play_arrow,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DiseaseSelectionScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color(0xFFAF76FA), // Primary color
        iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
        // Replace title text with an image
        title: Image.asset(
          'lib/assets/smile_white.png',
          height: 75, // adjust height as needed
        ),
      ),
    );
  }
}
