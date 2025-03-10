import 'package:flutter/material.dart';
import 'home_screen.dart'; // ✅ Import หน้า HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// ✅ หน่วงเวลา 3 วินาทีแล้วไปหน้า HomeScreen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A237E), // ✅ ใช้ธีมสีน้ำเงินเข้มแบบ Wongnai
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ✅ โลโก้แอป (ใช้ Image.asset ถ้ามีโลโก้)
            Image.asset('assets/images/wongnai.png', width: 150), 
            SizedBox(height: 20),

            /// ✅ แสดงแถบโหลดหมุน ๆ
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),

            SizedBox(height: 10),
            Text(
              "กำลังโหลด...",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
