import 'package:flutter_application_2/views/freelance.dart';
import 'package:flutter_application_2/views/lawfirms.dart';
import 'package:flutter_application_2/views/lawyer_signup.dart';
import 'package:flutter_application_2/views/lawyerlogin.dart';
import 'package:flutter_application_2/views/lawyers.dart';
import 'package:flutter_application_2/views/profile.dart';
import 'package:flutter_application_2/views/registration.dart';
import 'package:flutter_application_2/views/splashscreen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_2/views/homescreen.dart';
import 'package:flutter_application_2/views/login.dart';
import 'package:flutter_application_2/views/signup.dart';
import 'package:flutter_application_2/views/notifications.dart';

var routes = [
  GetPage(name: '/', page: () => LoginScreen()),
  GetPage(name: '/homescreen', page: () => HomeScreen()),

  GetPage(name: '/signup', page: () => SignupScreen()),
  GetPage(name: '/splashscreen', page: () => SplashScreen()),
  GetPage(name: '/lawyersignup', page: () => LawyerSignup()),
  GetPage(name: '/profile', page: () => Profile()),
  GetPage(name: '/lawyers', page: () => Lawyers()),
  GetPage(name: '/freelance', page: () => FreeLance()),
  GetPage(name: '/lawyerlogin', page: () => LawyerLogin()),
  GetPage(name: '/notification', page: () => NotificationScreen()),
  GetPage(name: '/lawfirms', page: () => LawFirms()),
  GetPage(name: '/Register', page: () => RegistrationForm()),
  GetPage(name: '/notification', page: () => NotificationScreen()),
];
