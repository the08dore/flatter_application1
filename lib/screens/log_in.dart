import 'package:flutter/material.dart';
import '../configs/colors.dart';
import 'sign_up.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("sign_up.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),

                  Image.asset("logo.jpg", height: 200, width: 200),

                  SizedBox(height: 20),

                  Text(
                    "Login Screen",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Use email or phone number",
                      labelStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Pin or password",
                      labelStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          " Sign up",
                          style: TextStyle(color: Colors.cyanAccent),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "forgot password?",
                        style: TextStyle(color: Colors.cyanAccent),
                      ),
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
