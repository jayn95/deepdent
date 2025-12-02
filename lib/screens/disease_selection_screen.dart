import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../screens/gingi-ins.dart'; // add import for the new route
import '../screens/perio-ins.dart'; //

class DiseaseSelectionScreen extends StatelessWidget {
  const DiseaseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Detection Type")),
      body: Column(
        children: [
          // Fixed search box at the top
          Padding(
            padding: const EdgeInsets.all(20),
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

          // Scrollable section for the rest
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gingivitis Section
                  const SizedBox(height: 20),
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
                            builder: (context) => const GingiInsScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFF9B72CF),
                  ),
                  const SizedBox(height: 20),

                  // Periodontitis Section
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
                            builder: (context) => const PerioInsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20), // extra bottom padding
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
