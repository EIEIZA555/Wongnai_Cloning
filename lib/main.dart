import 'package:flutter/material.dart';
import '../screens/splash_screen.dart'; // ✅ Import SplashScreen

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(), // ✅ ใช้ SplashScreen เป็นหน้าแรก
  ));
}
