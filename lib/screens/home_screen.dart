import 'package:flutter/material.dart';
import '../screens/disease_selection_screen.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFFA),
        elevation: 0,
        centerTitle: true,
        title: Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(4),
          child: Image.asset(
            "assets/logo/name.png", // ← replace with your logo
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/choice.png",
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 15),
            const Text(
              "Take control of your gum health now.",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF2F184B),
                fontFamily: 'InterTight',
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              "Instantly detect potential gum disease risks from home, empowering you to seek professional care exactly when you need it.",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF2F184B),
                fontFamily: 'InterTight',
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Start button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Let's go",
                icon: Icons.play_arrow,
                backgroundColor: const Color(
                  0xFF9B72CF,
                ), // button background color
                textColor: Colors.white, // text color
                iconColor: Colors.white, // icon color
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
    );
  }
}
