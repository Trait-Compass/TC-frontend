import 'package:flutter/material.dart';
import '../pages/creataccount.dart'; // SignupScreen 파일을 import

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isRememberMeChecked = false;

  void _login() {
    final String id = _idController.text;
    final String password = _passwordController.text;

    // 로그인 로직을 여기에 추가합니다.
    // 예를 들어, 토스트 메시지를 표시할 수 있습니다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('로그인 시도: $id')),
    );
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
            Image.asset(
              'assets/mbtilogo.jpg', // 여기에 로고 이미지의 경로를 넣으세요.
              height: 100, // 이미지의 높이를 적절히 조절하세요.
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
                      activeColor: Colors.black, // 체크박스의 배경 색상을 검정색으로 설정
                      checkColor: Colors.white, // 체크박스의 체크 색상을 흰색으로 설정
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
                backgroundColor: Colors.grey, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // TextField와 동일한 모서리 반경
                  side: BorderSide(color: Colors.grey), // TextField와 동일한 테두리 색상
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // 카카오 로그인 로직 추가
              },
              icon: Image.asset('assets/kakao_icon.png',
                  height: 24), // 카카오 아이콘 추가
              label: Text('카카오로 시작하기'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Background color
                foregroundColor: Colors.black, // Text color
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // TextField와 동일한 모서리 반경
                  side: BorderSide(color: Colors.grey), // TextField와 동일한 테두리 색상
                ),
              ),
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
                    foregroundColor: Colors.grey, // 텍스트 색상을 검정색으로 변경
                    textStyle: TextStyle(fontSize: 12), // 글씨 크기를 작게 설정
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(color: Colors.grey), // 텍스트 색상을 회색으로 변경
                ),
                TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 로직 추가
                  },
                  child: Text('비밀번호 찾기'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey, // 텍스트 색상을 검정색으로 변경
                    textStyle: TextStyle(fontSize: 12), // 글씨 크기를 작게 설정
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(color: Colors.grey), // 텍스트 색상을 회색으로 변경
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
                    foregroundColor: Colors.grey, // 텍스트 색상을 검정색으로 변경
                    textStyle: TextStyle(fontSize: 12), // 글씨 크기를 작게 설정
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
