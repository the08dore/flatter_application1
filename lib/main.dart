import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/login.dart';
import 'package:flutter_application_2/routes.dart';
import 'package:flutter_application_2/views/splashscreen.dart';
import 'package:flutter_application_2/controllers/notification_controller.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
      initialBinding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
    ),
  );
}
