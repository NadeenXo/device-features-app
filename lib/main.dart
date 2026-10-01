import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const DeviceFeaturesApp());
}

class DeviceFeaturesApp extends StatelessWidget {
  const DeviceFeaturesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Device Features',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}