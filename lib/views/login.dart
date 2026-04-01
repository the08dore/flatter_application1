import 'package:flutter/material.dart';
import 'package:flutter_application_2/config/colors.dart';
import 'package:flutter_application_2/controllers/logincontroller.dart';
import 'package:get/get.dart';

// FIX: Removed unused "import 'package:http/http.dart' as http;"
// FIX: Moved controllers inside the State class to avoid global state leaks
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // FIX: Declare controllers here so they are disposed with the widget
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // FIX: Always dispose TextEditingControllers to free memory
    usernameController.dispose();
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
                        "Enter Username",
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
                    controller: usernameController,
                    style: const TextStyle(color: Colors.white),
                    // FIX: Set keyboard type to email for better UX
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: "Use email or phone number",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.person),
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

                  // FIX: Wrap login button with Obx to show loading indicator
                  Obx(
                    () => GestureDetector(
                      onTap: loginController.isLoading.value
                          ? null // Disable tap while loading
                          : () async {
                              bool success = await loginController.login(
                                usernameController.text,
                                passwordController.text,
                              );
                              if (success) {
                                Get.toNamed("/homescreen");
                              } else {
                                Get.snackbar(
                                  'Log in failed',
                                  'Invalid username or password',
                                );
                              }
                            },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // FIX: Show spinner while loading, text otherwise
                        child: loginController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed('/lawyerlogin'),
                        child: const Text(
                          "log in as lawyer",
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
