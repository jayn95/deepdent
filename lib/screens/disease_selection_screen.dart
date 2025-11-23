import 'package:flutter/material.dart';
import '../screens/image_selection_screen.dart';

class DiseaseSelectionScreen extends StatelessWidget {
  const DiseaseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Removed gradient and replaced with solid white background
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Title
                const Text(
                  "Let's begin your journey to healthier gums.",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1C21), // Primary text
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Subtitle
                const Text(
                  "Please select one of the options below to proceed with gum detection",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7C818D), // Secondary text
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 70),
                // Image below title
                Container(
                  height: 180,
                  width: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/choice_char.png'), // replace with your image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                // Gingivitis Detection Button (replaced with styled ElevatedButton)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFAF76FA), // NEW button color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImageSelectionScreen(
                            detectionType: "gingivitis",
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(width: 8),
                        Text(
                          "Gingivitis",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Periodontitis Detection Button (replaced with styled ElevatedButton)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9F2FF), // NEW button color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImageSelectionScreen(
                            detectionType: "periodontitis",
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(width: 8),
                        Text(
                          "Periodontitis",
                          style: TextStyle(
                            color: Color(0xFF1A1C21),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
