import 'package:flutter/material.dart';
import '../../components/mbti_selection_page.dart';
import 'package:untitled/styles/loginstyles.dart';
import '../../services/auth_services.dart';
import 'creataccount.dart';
import '../../components/basic_frame_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/services/storagemobile.dart'; // 스토리지 서비스 임포트
import 'package:untitled/components/map/api.dart'; // ApiService 임포트

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService(); // 스토리지 서비스 인스턴스 생성
  bool _isRememberMeChecked = false;
  String _userInfo = '';
  String? _accessToken; // AccessToken 저장할 변수 추가

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

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        // 서버 응답에서 accessToken 추출
        if (responseBody.containsKey('result')) {
          _accessToken = responseBody['result'];
          print('Access Token: $_accessToken');

          // 스토리지 서비스에 토큰 저장
          await _storageService.write(key: 'accessToken', value: _accessToken!);
          print('Access Token stored successfully.');

          // ApiService에 accessToken 설정
          ApiService.setAccessToken(_accessToken!); // 스태틱 메서드로 접근

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 성공!')),
          );

          // 화면 전환
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BasicFramePage(body: MBTISelectionPage()),
            ),
          );
        } else {
          print('Access Token not found in the response.');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('아이디와 비밀번호를 확인해주세요')),
        );
      }
    } catch (e, stacktrace) {
      print('Exception during login: $e');
      print('Stack trace: $stacktrace');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 중 오류가 발생했습니다: $e')),
      );
    }
  }

  // 카카오 로그인 후 서버로 토큰 전송
  Future<void> _signInWithKakao() async {
    final token = await _authService.signInWithKakao(); 

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
          if (responseBody.containsKey('result')){
            _accessToken = responseBody['result'];
            await _storageService.write(
                key: 'accessToken', value: _accessToken!); // Secure Storage에 저장
            print('Access Token: $_accessToken'); 

            // ApiService에 accessToken 설정
            ApiService.setAccessToken(_accessToken!); // 스태틱 메서드로 설정

            setState(() {
              _userInfo = '로그인 성공!';
            });
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
            print('Access Token not found in the response.');
          }
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
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              // 로고 이미지 (필요에 따라 수정)
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
              // 아이디 입력 필드
              TextField(
                controller: _idController,
                decoration: textFieldDecoration.copyWith(hintText: '아이디'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              // 비밀번호 입력 필드
              TextField(
                controller: _passwordController,
                decoration: textFieldDecoration.copyWith(hintText: '비밀번호'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              // 로그인 상태 유지 체크박스
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
              // 로그인 버튼
              ElevatedButton(
                onPressed: _login,
                child: Text('로그인하기'),
                style: loginButtonStyle,
              ),
              SizedBox(height: 16),
              // 카카오 로그인 버튼
              ElevatedButton(
                onPressed: _signInWithKakao,
                style: kakaoButtonStyle,
                child: Image.asset(
                  'assets/kakao.png', // 경로 수정 필요 시 수정
                  height: 24,
                ),
              ),
              SizedBox(height: 24),
              // 로그인 결과 메시지
              if (_userInfo.isNotEmpty)
                Text(
                  _userInfo,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 24),
              // 아이디/비밀번호 찾기 및 회원가입 링크
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
      ),
    );
  }
}
