import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future<OAuthToken?> signInWithKakao() async {
    try {
      OAuthToken? token;

      // 카카오톡 실행 가능 여부 확인
      if (await isKakaoTalkInstalled()) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');
          if (error is PlatformException && error.code == 'CANCELED') {
            return null;
          }
          token = await _loginWithKakaoAccount();
        }
      } else {
        token = await _loginWithKakaoAccount();
      }

      return token;
    } catch (error) {
      print('카카오 로그인 실패: $error');
      return null;
    }
  }

  Future<OAuthToken?> _loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
      return token;
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
      return null;
    }
  }

  Future<void> sendTokenToServer(String accessToken) async {
    final response = await http.post(
      Uri.parse('https://your-backend.com/oauth/kakao'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'accessToken': accessToken,
        'vendor': 'kakao',
      }),
    );

    if (response.statusCode == 200) {
      print('서버로 토큰 전송 성공');
      // 서버로부터 받은 응답을 처리
    } else {
      print('서버로 토큰 전송 실패: ${response.statusCode}');
    }
  }

  Future<String?> getUserInfo() async {
    try {
      final user = await UserApi.instance.me();
      return '닉네임: ${user.kakaoAccount?.profile?.nickname}, 이메일: ${user.kakaoAccount?.email}';
    } catch (error) {
      print('사용자 정보 요청 실패: $error');
      return null;
    }
  }
}
