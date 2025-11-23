import 'package:flutter/material.dart';
<<<<<<< Updated upstream
<<<<<<< Updated upstream
import '../screens/image_selection_screen.dart';
=======
import '../widgets/custom_button.dart';
import '../screens/gingi-ins.dart'; // add import for the new route
import '../screens/perio-ins.dart'; //
>>>>>>> Stashed changes
=======
import '../widgets/custom_button.dart';
import '../screens/gingi-ins.dart'; // add import for the new route
import '../screens/perio-ins.dart'; //
>>>>>>> Stashed changes

class DiseaseSelectionScreen extends StatelessWidget {
  const DiseaseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
<<<<<<< Updated upstream
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: const Color(0xFFAF76FA), // Primary color
        iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
        // Replace title text with an image
        title: Image.asset(
          'lib/assets/smile_white.png',
          height: 75, // adjust height as needed
=======
      appBar: AppBar(title: const Text("Select Detection Type")),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFF532B88), width: 1.5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: const [
        Icon(
          Icons.search_outlined,
          color: Color(0xFF532B88),
          size: 40,
>>>>>>> Stashed changes
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "What are you checking for today?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF532B88),
            ),
          ),
        ),
      ],
    ),
  ),
),
          // Upper half: Gingivitis
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "1. Gingivitis Detection",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color(0xFF532B88),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "What it is: The early stage of gum disease.\nSigns: Redness, swelling, or gums that bleed easily when brushing/flossing.",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Color(0xFF9B72CF),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Recommended for initial or routine checks.",
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF2F184B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Check for Gingivitis",
                      icon: Icons.camera_alt_outlined,
                      backgroundColor: const Color(0xFF9B72CF),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GingiInsScreen(), // route changed to gingi-ins.dart
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // horizontal divider instead of different background for perio
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF9B72CF),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "2. Periodontitis Detection",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color(0xFF532B88),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "What it is: The advanced stage of gum disease.\nSigns: Receding gums, persistent bad breath, loose teeth, or visible gaps between teeth.",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Color(0xFF9B72CF),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Recommended if you have severe or chronic symptoms.",
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF2F184B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Check for Periodontitis",
                      icon: Icons.image_outlined,
                      backgroundColor: const Color(0xFF9B72CF),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PerioInsScreen(), // route changed to perio-ins.dart
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
=======
      appBar: AppBar(title: const Text("Select Detection Type")),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFF532B88), width: 1.5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: const [
        Icon(
          Icons.search_outlined,
          color: Color(0xFF532B88),
          size: 40,
>>>>>>> Stashed changes
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "What are you checking for today?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF532B88),
            ),
          ),
        ),
      ],
    ),
  ),
),
          // Upper half: Gingivitis
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "1. Gingivitis Detection",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color(0xFF532B88),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "What it is: The early stage of gum disease.\nSigns: Redness, swelling, or gums that bleed easily when brushing/flossing.",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Color(0xFF9B72CF),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Recommended for initial or routine checks.",
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF2F184B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Check for Gingivitis",
                      icon: Icons.camera_alt_outlined,
                      backgroundColor: const Color(0xFF9B72CF),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GingiInsScreen(), // route changed to gingi-ins.dart
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // horizontal divider instead of different background for perio
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFF9B72CF),
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "2. Periodontitis Detection",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color(0xFF532B88),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "What it is: The advanced stage of gum disease.\nSigns: Receding gums, persistent bad breath, loose teeth, or visible gaps between teeth.",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: Color(0xFF9B72CF),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Recommended if you have severe or chronic symptoms.",
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF2F184B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Check for Periodontitis",
                      icon: Icons.image_outlined,
                      backgroundColor: const Color(0xFF9B72CF),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PerioInsScreen(), // route changed to perio-ins.dart
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
