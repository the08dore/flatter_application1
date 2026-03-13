import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'views/login.dart';
import 'package:flutter_application_2/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: routes,
    ),
  );
}
