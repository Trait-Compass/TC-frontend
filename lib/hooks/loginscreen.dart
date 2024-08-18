import 'package:flutter/material.dart';
import '../components/mbti_selection_page.dart';
import '../styles/loginstyles.dart';
import '../services/auth_services.dart';
import 'creataccount.dart';
import '../components/basic_frame_page.dart';

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

  void _login() {
    final String id = _idController.text;
    final String password = _passwordController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('로그인 시도: $id')),
    );
  }

  Future<void> _signInWithKakao() async {
    final token = await _authService.signInWithKakao();

    if (token != null) {
      setState(() {
        _userInfo = '로그인 성공!';
      });

      final userInfo = await _authService.getUserInfo();
      setState(() {
        _userInfo = userInfo ?? '사용자 정보 요청 실패';
      });

      await _authService.sendTokenToServer(token.accessToken);
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
                                SignupScreen()), // 수정: SignupScreen으로 이동
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
