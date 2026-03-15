import 'package:flutter_application_2/views/splashscreen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_2/views/homescreen.dart';
import 'package:flutter_application_2/views/login.dart';
import 'package:flutter_application_2/views/signup.dart';

var routes = [
  GetPage(name: '/', page: () => LoginScreen()),
  GetPage(name: '/homescreen', page: () => HomeScreen()),
  GetPage(name: '/signup', page: () => SignupScreen()),
  GetPage(name: '/splashscreen', page: () => SplashScreen()),
];
