import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/colors.dart';
import 'package:get/get.dart';

class LawyerLogin extends StatefulWidget {
  const LawyerLogin({super.key});

  @override
  State<LawyerLogin> createState() => _LawyerLoginState();
}

class _LawyerLoginState extends State<LawyerLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sign_up.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.jpg', height: 200, width: 200),

                  SizedBox(height: 20),

                  Text(
                    "Login Screen",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Username",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Use email or phone number",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter password",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Pin or password",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),

                  SizedBox(height: 30),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/homescreen");
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),

                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/lawyersignup');
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Spacer(),
                      SizedBox(width: 10),
                      Text(
                        "Forgot password? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text("Reset", style: TextStyle(color: Colors.blue)),
                    ],
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
