import 'package:flutter/material.dart';
import 'mbti_selection_page.dart'; // MBTI 선택 페이지 파일을 import
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() => runApp(MBTISelectionApp());

void main() {
    ...
    // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
    WidgetsFlutterBinding.ensureInitialized();

    // runApp() 호출 전 Flutter SDK 초기화
    KakaoSdk.init(
        nativeAppKey: '${YOUR_NATIVE_APP_KEY}',
        javaScriptAppKey: '${YOUR_JAVASCRIPT_APP_KEY}',
    );
    runApp(MyApp());
    ...
}