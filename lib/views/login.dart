import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/colors.dart';
import 'package:flutter_application_2/controllers/logincontroller.dart';
import 'package:flutter_application_2/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/config/api.dart';

class LoginScreen extends StatefulWidget {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  // Register UserController so it's available globally across all screens
  final UserController userController = Get.put(UserController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sign_up.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.jpg', height: 200, width: 200),
                  const SizedBox(height: 20),
                  Text(
                    "Login Screen",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Email",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Enter email",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),

                  const SizedBox(height: 30),

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
                  const SizedBox(height: 10),

                  Obx(
                    () => TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !loginController.isPasswordVisible.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Pin or password",
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: loginController.togglePassword,
                          child: Icon(
                            loginController.isPasswordVisible.value
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Get.toNamed('/signup'),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Forgot password? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text("Reset", style: TextStyle(color: Colors.blue)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: () async {
                      if (emailController.text.isEmpty) {
                        Get.snackbar("error", "Enter email");
                      } else if (passwordController.text.isEmpty) {
                        Get.snackbar("error", "Enter password");
                      } else {
                        final response = await http.get(
                          Api.login(
                            emailController.text,
                            passwordController.text,
                          ),
                        );

                        print(response.body);

                        if (response.statusCode == 200) {
                          final serverData = jsonDecode(response.body);

                          if (serverData['code'] == 1) {
                            // FIX: Save user data globally so all screens can use it
                            userController.setUser(
                              serverData['userdetails'][0],
                            );
                            Get.toNamed('/homescreen');
                          } else {
                            Get.snackbar(
                              "Wrong Details",
                              serverData["message"],
                            );
                          }
                        } else {
                          Get.snackbar("Server error", "Login failed");
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
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () => Get.toNamed('/stafflogin'),
                    child: const Text(
                      "Login as staff",
                      style: TextStyle(color: Colors.blue),
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
