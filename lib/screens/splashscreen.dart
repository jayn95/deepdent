import 'package:flutter/material.dart';
import '../screens/home_screen.dart'; // Ensure this path is correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation<double> _circleScaleAnimation; // 1. Circle expansion
  late Animation<double> _logoFadeAnimation;    // 2. Logo flash/visibility
  late Animation<Offset> _logoSlideAnimation;   // 3. Logo vertical movement
  late Animation<double> _logoShrinkAnimation;  // 4. Logo final shrink

  // --- Animation Timing Constants (in milliseconds) ---
  static const int _totalDurationMs = 4000;  // Increased total time for the final shrink
  static const int _scaleEndMs = 1500;       // Circle fills screen
  static const int _fadeStartMs = 1200;      // Logo starts appearing
  static const int _slideStartMs = 2000;     // Logo starts moving up
  static const int _shrinkStartMs = 3000;    // Logo starts shrinking at the top
  // ----------------------------------------------------

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _totalDurationMs),
    );

    // 1. Expanding Circle Animation (0ms to 1500ms)
    _circleScaleAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0, 
          _scaleEndMs / _totalDurationMs, 
          curve: Curves.easeInOut,
        ),
      ),
    );

    // 2. Logo Fade-In/Visibility (1200ms to 2000ms). Controls when logo is visible.
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        // Logo is fully visible by the time it starts moving
        curve: const Interval(
          _fadeStartMs / _totalDurationMs, 
          _slideStartMs / _totalDurationMs, 
          curve: Curves.easeIn,
        ),
      ),
    );

    // 3. Logo Slide Up Animation (2000ms to 3000ms). Slides up full size.
    _logoSlideAnimation = Tween<Offset>(
      begin: Offset.zero, // Center
      end: const Offset(0.0, -1.4), // Near the very top edge
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          _slideStartMs / _totalDurationMs, 
          _shrinkStartMs / _totalDurationMs, // Stops sliding when shrink starts
          curve: Curves.easeOut, 
        ),
      ),
    );
    
    // 4. Logo Final Shrink Animation (3000ms to 4000ms). Shrinks at the top.
    _logoShrinkAnimation = Tween<double>(
      begin: 1.0,  // Start at full size (100%)
      end: 0.4,    // Shrink to 50% of 250px (final small logo size)
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          _shrinkStartMs / _totalDurationMs, 
          1.0, // Ends at the total duration
          curve: Curves.easeInOut, 
        ),
      ),
    );

    _animationController.forward();

    // Navigate only after all animations are complete (4200ms total delay)
    Future.delayed(const Duration(milliseconds: 4200), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double maxDimension = MediaQuery.of(context).size.shortestSide * 2.5; 
    const Color initialBackgroundColor = Color(0xFF5A3C8B); 
    const Color finalExpansionColor = Color(0xFFF4EFFA); 

    return Scaffold(
      backgroundColor: initialBackgroundColor, 
      body: Stack(
        alignment: Alignment.center, 
        children: [
          // 1. The Expanding Circle 
          AnimatedBuilder(
            animation: _circleScaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _circleScaleAnimation.value,
                child: Container(
                  width: maxDimension / 10, 
                  height: maxDimension / 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: finalExpansionColor, 
                  ),
                ),
              );
            },
          ),
          
          // 2, 3, & 4. Logo Flash, Slide, and Shrink
          Center(
            child: SlideTransition( // 3. Handles the vertical movement (center to top)
              position: _logoSlideAnimation,
              child: FadeTransition( // 2. Controls initial visibility/flash
                opacity: _logoFadeAnimation,
                child: ScaleTransition( // 4. Handles the final shrink at the end
                  scale: _logoShrinkAnimation,
                  child: Image.asset(
                    'assets/logo/name-logo.png', // CRITICAL: Verify this path
                    width: 250, 
                    height: 250,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}