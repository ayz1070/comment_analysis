import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/di/app_binding.dart';
import 'presentation/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mofix 리뷰 분석',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialBinding: AppBinding(),
      home: const HomePage(),
    );
  }
}
