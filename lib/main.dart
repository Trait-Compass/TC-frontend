import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/basic_frame_page.dart'; // 기본 프레임 페이지 파일을 import
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import '../components/mbti_selection_page.dart';

void main() async {
  // Flutter 앱의 runApp() 호출 전 초기화를 위해서 필요한 메서드 호출
  WidgetsFlutterBinding.ensureInitialized();

  // Kakao SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '943a707ffc4c5c863f19e8705f7f88a3',
    javaScriptAppKey: '3138f5bc6deb5700f9f140cf8c36cab3',
  );

  runApp(MBTISelectionApp());
}

class MBTISelectionApp extends StatelessWidget {
  // MethodChannel 정의
  static const platform = MethodChannel('kakao/map');

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kakao Map Example'),
        ),
        body: BasicFramePage(
          body: MBTISelectionPage(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              final result = await platform.invokeMethod('showKakaoMap');
              print(result);
            } on PlatformException catch (e) {
              print("Failed to show Kakao Map: '${e.message}'.");
            }
          },
          child: Icon(Icons.map),
        ),
      ),
    );
  }
}
