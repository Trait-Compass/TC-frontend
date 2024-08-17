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

    if (isButtonEnabled) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            id: id, // 사용자가 입력한 id 전달
            password: password, // 사용자가 입력한 password 전달
          ),
        ),
      );
    }
  }

  void _checkDuplicate() {
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.8,
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/mbtilogo.jpg',
                    height: screenHeight * 0.1,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '아이디',
                        style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: screenHeight * 0.06,
                              child: TextField(
                                controller: _idController,
                                decoration: InputDecoration(
                                  hintText: '아이디 또는 이메일을 입력해주세요',
                                  hintStyle: TextStyle(
                                    fontSize: screenHeight * 0.017,
                                    color: Color(0xFF676767),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF1F2F3),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F2F3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F2F3),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFF1F2F3),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Container(
                            width: screenWidth * 0.2,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: _checkDuplicate,
                              child: Text(
                                '중복 확인',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.017,
                                  color: Colors.black,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(color: Color(0xFFD9D9D9)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        '비밀번호',
                        style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: screenHeight * 0.06,
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: '비밀번호를 입력해주세요',
                            hintStyle: TextStyle(
                              fontSize: screenHeight * 0.017,
                              color: Color(0xFF676767),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F2F3),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04),
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        '비밀번호 확인',
                        style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: screenHeight * 0.06,
                        child: TextField(
                          controller: _passwordConfirmController,
                          decoration: InputDecoration(
                            hintText: '비밀번호를 다시 한번 더 입력해주세요',
                            hintStyle: TextStyle(
                              fontSize: screenHeight * 0.017,
                              color: Color(0xFF676767),
                            ),
                            filled: true,
                            fillColor: Color(0xFFF1F2F3),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFF1F2F3),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04),
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.06,
                      margin: EdgeInsets.only(bottom: screenHeight * 0.25),
                      child: ElevatedButton(
                        onPressed: isButtonEnabled ? _signup : null,
                        child: Text(
                          '가입하기',
                          style: TextStyle(
                            fontSize: screenHeight * 0.025,
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
