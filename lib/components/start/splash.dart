import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/mbti.png',
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'MBTI로 떠나는 여행',
              style: TextStyle(fontSize: 20, color: Colors.grey[200]),
            ),
          ],
        ),
      ),
    );
  }
}
