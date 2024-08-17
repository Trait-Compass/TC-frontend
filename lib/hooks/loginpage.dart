import 'package:flutter/material.dart';
import 'creataccount.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../components/basic_frame_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRememberMeChecked = false;
  String _userInfo = '';

  void _login() {
    final String id = _idController.text;
    final String password = _passwordController.text;

    // 로그인 로직을 여기에 추가합니다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('로그인 시도: $id')),
    );
  }

  Future<void> signInWithKakao() async {
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
            return;
          }
          token = await _loginWithKakaoAccount();
        }
      } else {
        token = await _loginWithKakaoAccount();
      }

      // 로그인 성공 시 사용자 정보 가져오기
      await _getUserInfo();

      // 카카오에서 받은 액세스 토큰을 서버로 전송
      if (token != null) {
        await _sendTokenToServer(token.accessToken);
      }
    } catch (error) {
      print('카카오 로그인 실패: $error');
      setState(() {
        _userInfo = '카카오 로그인 실패: $error';
      });
    }
  }

  Future<OAuthToken?> _loginWithKakaoAccount() async {
    try {
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공');
      return token;
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
      setState(() {
        _userInfo = '카카오계정으로 로그인 실패: $error';
      });
      return null;
    }
  }

  Future<void> _getUserInfo() async {
    try {
      final user = await UserApi.instance.me();
      setState(() {
        _userInfo =
            '닉네임: ${user.kakaoAccount?.profile?.nickname}, 이메일: ${user.kakaoAccount?.email}';
      });
      print('사용자 정보: $_userInfo');
    } catch (error) {
      print('사용자 정보 요청 실패: $error');
      setState(() {
        _userInfo = '사용자 정보 요청 실패: $error';
      });
    }
  }

  Future<void> _sendTokenToServer(String accessToken) async {
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
      // 예: 서버가 새로운 세션 토큰을 반환하면 그것을 저장하는 등의 작업
    } else {
      print('서버로 토큰 전송 실패: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BasicFramePage()),
                );
              },
              child: Image.asset(
                'assets/mbtilogo.jpg', // 로고 이미지 경로
                height: 100, // 이미지 높이
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                hintText: '아이디',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: '비밀번호',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _isRememberMeChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isRememberMeChecked = value ?? false;
                        });
                      },
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                    ),
                    Text(
                      '로그인 유지',
                      style: TextStyle(
                        color:
                            _isRememberMeChecked ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('로그인하기'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: signInWithKakao,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              child: Image.asset(
                '../assets/kakao.png', // 요청하신 이미지 경로
                height: 24,
              ),
            ),
            SizedBox(height: 24),
            if (_userInfo.isNotEmpty)
              Text(
                _userInfo,
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // 아이디 찾기 로직 추가
                  },
                  child: Text('아이디 찾기'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    textStyle: TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 로직 추가
                  },
                  child: Text('비밀번호 찾기'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    textStyle: TextStyle(fontSize: 12),
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text('회원가입'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    textStyle: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
