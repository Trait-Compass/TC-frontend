import 'package:flutter/material.dart';
import '../components/mbti_selection_page.dart';
import '../styles/loginstyles.dart';
import '../services/auth_services.dart';
import 'creataccount.dart';
import '../components/basic_frame_page.dart';
import 'package:http/http.dart' as http;  
import 'dart:convert';  

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isRememberMeChecked = false;
  String _userInfo = '';
  String? _accessToken;  // AccessToken 저장할 변수 추가

  // 로그인 API 호출 메서드
  Future<void> _login() async {
    final String id = _idController.text;
    final String password = _passwordController.text;

    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디와 비밀번호를 모두 입력해주세요.')),
      );
      return;
    }

    // 로그인 API 요청
    final url = Uri.parse('https://www.traitcompass.store/user/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'password': password}),
      );

      print('Response Status Code: ${response.statusCode}');  // 상태 코드 출력
      print('Response Body: ${response.body}');  // 응답 본문 출력

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        
        // 서버 응답에서 accessToken 추출
        if (responseBody.containsKey('result') && responseBody['result'].containsKey('accessToken')) {
          _accessToken = responseBody['result']['accessToken'];
          print('Access Token: $_accessToken');  // 디버깅용
        } else {
          print('Access Token not found in the response.');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 성공!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BasicFramePage(body: MBTISelectionPage()),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 실패. 아이디와 비밀번호를 확인해주세요. 상태 코드: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 중 오류가 발생했습니다: $e')),
      );
    }
  }

  // 카카오 로그인 후 서버로 토큰 전송
  Future<void> _signInWithKakao() async {
    final token = await _authService.signInWithKakao();  // Kakao 인증 통해 토큰 획득

    if (token != null) {
      // 서버로 전송하여 로그인/회원가입 요청
      final url = Uri.parse('https://www.traitcompass.store/oauth/kakao');
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'accessToken': token, 'vendor': 'kakao'}),
        );

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 201) {
          final Map<String, dynamic> responseBody = jsonDecode(response.body);
          
          // 서버로부터 받은 accessToken 저장
          if (responseBody.containsKey('result') && responseBody['result'].containsKey('accessToken')) {
            _accessToken = responseBody['result']['accessToken'];
            print('Access Token: $_accessToken');  // 디버깅용
          } else {
            print('Access Token not found in the response.');
          }

          setState(() {
            _userInfo = '로그인 성공!';
          });

          // 이후 작업 - 예: 다음 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BasicFramePage(body: MBTISelectionPage()),
            ),
          );
        } else {
          setState(() {
            _userInfo = '로그인 실패. 상태 코드: ${response.statusCode}';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 실패. 상태 코드: ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 중 오류가 발생했습니다: $e')),
        );
      }
    } else {
      setState(() {
        _userInfo = '로그인 실패';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BasicFramePage(body: MBTISelectionPage()),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/mbtilogo.jpg',
                  height: 100,
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _idController,
                decoration: textFieldDecoration.copyWith(hintText: '아이디'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: textFieldDecoration.copyWith(hintText: '비밀번호'),
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
                          color: _isRememberMeChecked ? Colors.black : Colors.grey,
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
                style: loginButtonStyle,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signInWithKakao,
                style: kakaoButtonStyle,
                child: Image.asset(
                  '../assets/kakao.png',
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
                        MaterialPageRoute(
                            builder: (context) =>
                                SignupScreen()), 
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
      ),
    );
  }
}
