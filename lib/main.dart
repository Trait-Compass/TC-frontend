import 'package:flutter/material.dart';
import 'components/basic_frame_page.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import '../components/mbti_selection_page.dart';
import '../components/start/onboarding.dart'; 
import '../components/start/splash.dart'; 
import '../components/Mypage/myprofilefirstpage.dart'; 
import '../pages/travelplan.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '943a707ffc4c5c863f19e8705f7f88a3',
    javaScriptAppKey: '3138f5bc6deb5700f9f140cf8c36cab3',
  );

  runApp(MBTISelectionApp());
}

class MBTISelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontWeight: FontWeight.bold),
          displayLarge: TextStyle(fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontWeight: FontWeight.bold),
          labelMedium: TextStyle(fontWeight: FontWeight.bold),
          labelSmall: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingPage(),
        '/main': (context) => BasicFramePage(body: MBTISelectionPage()),
        '/mypage': (context) => Mypage(),
        '/travelplan': (context) => MyNewPage(),
      },
    );
  }
}
