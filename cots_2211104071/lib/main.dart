import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cots_2211104071/modules/onboarding_page/view/onboarding_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding App',
      home: OnboardingPage(),
    );
  }
}