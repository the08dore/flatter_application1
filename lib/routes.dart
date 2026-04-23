import 'package:flutter_application_2/views/freelance.dart';
//import 'package:flutter_application_2/views/lawfirms.dart';
//import 'package:flutter_application_2/views/staff_signup.dart';
//import 'package:flutter_application_2/views/stafflogin.dart';
import 'package:flutter_application_2/views/lawyers.dart';
import 'package:flutter_application_2/views/profile.dart';
import 'package:flutter_application_2/views/registration.dart';
import 'package:flutter_application_2/views/splashscreen.dart';
import 'package:flutter_application_2/views/staff_dashboard_screen.dart';
import 'package:flutter_application_2/views/staff_login_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_2/views/homescreen.dart';
import 'package:flutter_application_2/views/login.dart';
import 'package:flutter_application_2/views/signup.dart';
import 'package:flutter_application_2/views/notifications.dart';
import 'package:flutter_application_2/views/my_applications_screen.dart';

var routes = [
  GetPage(name: '/', page: () => LoginScreen()),
  GetPage(name: '/homescreen', page: () => HomeScreen()),
  GetPage(name: '/signup', page: () => SignupScreen()),
  GetPage(name: '/splashscreen', page: () => SplashScreen()),
  //GetPage(name: '/staffsignup', page: () => StaffSignupScreen()),
  GetPage(name: '/profile', page: () => Profile()),
  GetPage(name: '/staff', page: () => Lawyers()),
  GetPage(name: '/freelance', page: () => FreeLance()),
  //GetPage(name: '/stafflogin', page: () => StaffLoginScreen()),
  GetPage(
    name: '/notification',
    page: () => PersonalNotificationsScreen(userId: Get.arguments ?? ''),
  ),

  //GetPage(name: '/lawfirms', page: () => LawFirms()),
  GetPage(
    name: '/register',
    page: () => Register(userProfile: Get.arguments ?? {}),
  ),

  GetPage(name: '/stafflogin', page: () => StaffLoginScreen()),
  GetPage(
    name: '/staffdashboard',
    page: () => StaffDashboardScreen(staffName: Get.arguments ?? ''),
  ),
  GetPage(
    name: '/myapplications',
    page: () => MyApplicationsScreen(userEmail: Get.arguments ?? ''),
  ),
  GetPage(
    name: '/mynotifications',
    page: () => PersonalNotificationsScreen(userId: Get.arguments ?? ''),
  ),
];
