import 'package:flutter/material.dart';
import 'accountdetail.dart'; // accountdetail.dart 파일을 import

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool isButtonEnabled = false;

  void _signup() {
    final String id = _idController.text;
    final String password = _passwordController.text;
    final String passwordConfirm = _passwordConfirmController.text;

    // 모든 필드가 올바르게 입력되면 accountdetail.dart로 이동합니다.
    if (isButtonEnabled) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserInfoScreen()),
      );
    }
  }

  void _checkDuplicate() {
    // 중복 확인 로직을 여기에 추가합니다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('중복 확인')),
    );
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _idController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordConfirmController.text.isNotEmpty &&
          _passwordController.text == _passwordConfirmController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _idController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _passwordConfirmController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard', // 전체 글씨체를 Pretendard로 설정
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 360,
            height: 800,
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/mbtilogo.jpg', // 여기에 로고 이미지의 경로를 넣으세요.
                    height: 100, // 이미지의 높이를 적절히 조절하세요.
                  ),
                  SizedBox(height: 24),
                  Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '아이디',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 47,
                              child: TextField(
                                controller: _idController,
                                decoration: InputDecoration(
                                  hintText: '아이디 또는 이메일을 입력해주세요',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF676767),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF1F2F3),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                                    ),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 70,
                            height: 47,
                            child: ElevatedButton(
                              onPressed: _checkDuplicate,
                              child: Text(
                                '중복 확인',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color(0xFFD9D9D9), // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(color: Color(0xFFD9D9D9)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        '비밀번호',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 47,
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: '비밀번호를 입력해주세요',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF676767),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F2F3),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '비밀번호 확인',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 47,
                        child: TextField(
                          controller: _passwordConfirmController,
                          decoration: InputDecoration(
                            hintText: '비밀번호를 다시 한번 더 입력해주세요',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF676767),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F2F3),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3), // 테두리 색상을 변경합니다.
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 192,
                      height: 47,
                      margin: EdgeInsets.only(bottom: 202),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled ? _signup : null,
                        child: Text(
                          '가입하기',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isButtonEnabled
                              ? Colors.black.withOpacity(0.28)
                              : Color(
                                  0xFFD9D9D9), // Background color with 28% opacity or disabled color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(
                              color: isButtonEnabled
                                  ? Colors.black.withOpacity(0.28)
                                  : Color(0xFFD9D9D9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
