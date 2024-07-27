import 'package:flutter/material.dart';
import 'mbti_selection_page.dart'; // MBTI 선택 페이지 파일을 import
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
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
      title: 'MBTI Selection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MBTISelectionPage(),
    );
  }
}
