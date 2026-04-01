import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

TextEditingController firstname = TextEditingController();
TextEditingController lastname = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController passwordAgain = TextEditingController();

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Create Account"),
        backgroundColor: primaryColor,
      ),
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
                children: [
                  SizedBox(height: 40),

                  Image.asset("assets/logo.jpg", height: 100, width: 200),

                  SizedBox(height: 20),

                  Text(
                    "signupScreen",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        "First Name",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  TextField(
                    controller: firstname,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Enter first name",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(height: 5),

                  Row(
                    children: [
                      Text(
                        "Enter second name",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  TextField(
                    controller: lastname,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Enter second name",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        "Enter email ",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  TextField(
                    controller: email,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Enter email ",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  TextField(
                    controller: password,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Enter password",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Row(
                    children: [
                      Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5),

                  TextField(
                    controller: passwordAgain,
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm password",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  GestureDetector(
                    onTap: () async {
                      if (firstname.text.isEmpty) {
                        Get.snackbar("Error", "enter first name");
                      } else if (lastname.text.isEmpty) {
                        Get.snackbar("Error", "please enter last name");
                      } else if (email.text.isEmpty) {
                        Get.snackbar("Error", "Please enter email");
                      } else if (password.text.isEmpty) {
                        Get.snackbar("Error", "please enter password");
                      } else if (password.text != passwordAgain.text) {
                        Get.snackbar("Error", "Passwords do not match");
                      } else {
                        final response = await http.post(
                          Uri.parse(
                            "http://192.168.44.8/flutter_api/create.php",
                          ),
                          body: {
                            "firstname": firstname.text,
                            "lastname": lastname.text,
                            "email": email.text,
                            "password": password.text,
                          },
                        );

                        if (response.statusCode == 200) {
                          final serverData = jsonDecode(response.body); //

                          if (serverData['success'] == 1) {
                            Get.snackbar("success", "You are registered");
                            Get.toNamed('/splashscreen');
                          } else {
                            Get.snackbar("Error", "Registration failed");
                          }
                        } else {
                          Get.snackbar("Registration", "Server error");
                        }
                      }
                    },

                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Create Account",
                        style: TextStyle(color: secondaryColor, fontSize: 16),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "would you like to join as a lawyer",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),

                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/lawyersignup');
                        },
                        child: Text(
                          "click to join as lawyer",
                          style: TextStyle(color: Colors.blue),
                        ),
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
