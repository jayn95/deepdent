import 'package:flutter/material.dart';
import 'dart:async'; 
import '../screens/disease_selection_screen.dart';
import '../widgets/custom_button.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  final List<Map<String, dynamic>> slideData = [
    {
      'image': 'assets/images/idea.png', 
      'title': "Pre-Screening",
      'text': "Our analysis flags potential issues, but it is not a diagnosis. Monitor your gums, then see your dentist for a definitive medical assessment.",
    },
    {
      'image': 'assets/images/selfie.png', 
      'title': "AI Technology",
      'text': "Simply snap a photo of your gums and our algorithm provides a preliminary assessment in seconds.",
    },
    {
      'image': 'assets/images/trash.png',
      'title': "Commitment-Free",
      'text': "No registration, no login. Use the app instantly, knowing your images are never stored. Your data stays with you.",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start the timer for automatic sliding
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPage < slideData.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); 
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2F184B); 
    const Color accentColor = Color(0xFF9B72CF); 
    const Color lightBackground = Color(0xFFF4EFFA); 

    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: lightBackground,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          "assets/logo/name-logo.png", 
          height: 48,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.65, 
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slideData.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return buildSlide(
                      slideData[index]['image'] as String,
                      slideData[index]['title'] as String,
                      slideData[index]['text'] as String,
                      primaryColor,
                    );
                  },
                ),
              ),
              
              // Carousel Indicator Dots
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(slideData.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 8.0,
                      width: _currentPage == index ? 24.0 : 8.0,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? accentColor : accentColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),

              CustomButton(
                text: "Let's Get Started",
                backgroundColor: accentColor, 
                textColor: Colors.white, 
                iconColor: Colors.white, 
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiseaseSelectionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each slide card
  Widget buildSlide(String imagePath, String title, String text, Color primaryColor) {
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset( 
          imagePath,
          height: 180, 
          width: 180, 
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, size: 80, color: primaryColor.withOpacity(0.5));
          },
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'InterTight',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: primaryColor.withOpacity(0.8),
              fontFamily: 'InterTight',
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}