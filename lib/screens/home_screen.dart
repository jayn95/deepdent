import 'package:flutter/material.dart';
import '../screens/disease_selection_screen.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      // Gradient background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
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
=======
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
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/choice.png",
              width: 350,
              height: 350,
              fit: BoxFit.contain,
            ),
            
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
            // Welcome text
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
            CustomButton(
              text: "Let's go",
              icon: Icons.play_arrow,
              backgroundColor: const Color(0xFF9B72CF), // button background color
              textColor: Colors.white,                     // text color
              iconColor: Colors.white,                     // icon color
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DiseaseSelectionScreen(),
>>>>>>> Stashed changes
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
