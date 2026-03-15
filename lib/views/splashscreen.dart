import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showBlur = false;
  bool showCard = false;

  @override
  void initState() {
    super.initState();

    // Show blur after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showBlur = true;
      });
    });

    // Show question card after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        showCard = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset("assets/splashB.jpg", fit: BoxFit.cover),
          ),

          /// BLUR EFFECT
          if (showBlur)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),
            ),

          /// QUESTION BOX
          if (showCard)
            Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: showCard ? 1 : 0,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "This is an adult application",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "This app contins age-restricted materials. By entering, you affirm that you are at least 18 years of age or majority of the age of the jurisdiction you are accecing this app from and you concent to our poloicy",
                        style: TextStyle(color: Colors.blue),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Get.offNamed('/homescreen');
                        },
                        child: const Text(
                          "I am 18 or older",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Get.toNamed('/');
                        },

                        child: const Text(
                          "i am under 18",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
