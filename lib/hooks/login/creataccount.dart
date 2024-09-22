import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'accountdetail.dart';
import '../login/termsofservice1.dart'; // 이용약관 페이지 임포트

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
  bool isIdUnique = false;
  bool isPasswordValid = true;
  bool isPasswordMatch = true;
  bool isAgreedToTerms = false; // 이용약관 동의 여부 추가

  void _signup() {
    final String id = _idController.text;
    final String password = _passwordController.text;

    if (isButtonEnabled && isIdUnique && isAgreedToTerms) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            id: id,
            password: password,
          ),
        ),
      );
    }
  }

  Future<void> _checkDuplicateId() async {
    final String id = _idController.text;

    final response =
        await http.get(Uri.parse('https://www.traitcompass.store/user/id/$id'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final String responseBody = response.body;
      final bool isIdTaken = responseBody.contains('"result":false');

      if (isIdTaken) {
        setState(() {
          isIdUnique = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('사용 가능한 아이디입니다.')),
        );
        print('사용 가능한 아이디입니다.');
      } else {
        setState(() {
          isIdUnique = false; // 이미 사용 중인 ID
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미 사용 중인 아이디입니다.')),
        );
        print('이미 사용 중인 아이디입니다.');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('아이디 중복 확인에 실패했습니다.')),
      );
      print('아이디 중복 확인 실패');
    }

    _updateButtonState();
  }

  bool _validatePassword(String password) {
    // 최소 한 개의 영문자 포함, 최소 한 개의 숫자 포함, 최소 한 개의 특수 문자 포함, 8자 이상
    final passwordRegex = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _updateButtonState() {
    final String password = _passwordController.text;
    final String confirmPassword = _passwordConfirmController.text;
    setState(() {
      isPasswordValid = password.isEmpty ||
          _validatePassword(password); // 비밀번호가 입력되지 않은 상태에서도 유효성 검사
      isPasswordMatch = confirmPassword.isEmpty ||
          password == confirmPassword; // 비밀번호와 확인 비밀번호가 일치하는지 검사
      isButtonEnabled = _idController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordConfirmController.text.isNotEmpty &&
          _passwordController.text == _passwordConfirmController.text &&
          isPasswordValid &&
          isPasswordMatch &&
          isIdUnique &&
          isAgreedToTerms; // 약관 동의 여부 추가
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

    return Scaffold(
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
                // 약관 동의 및 확인 버튼을 한 줄로 배치하고 아이디 위로 이동
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isAgreedToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          isAgreedToTerms = value ?? false;
                          _updateButtonState(); // 체크박스 변경 시 버튼 활성화 상태 업데이트
                        });
                      },
                      activeColor: Colors.black,
                    ),
                    Expanded(
                      child: Text(
                        "회원가입 및 이용약관에 \n동의하겠습니다",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndConditionsPage1(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        elevation: 0,
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Text(
                        '이용약관 확인하기',
                        style: TextStyle(
                          fontSize: screenHeight * 0.012,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03), // 아이디 입력란과 간격 추가
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
                                  fontSize: 10,
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
                          height: screenHeight * 0.06,
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: _checkDuplicateId,
                            child: Text(
                              '중복 확인',
                              style: TextStyle(
                                fontSize: 12,
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
                          hintText: '영문자, 숫자, 특수문자를 포함해 8자 이상 비밀번호 입력 필수',
                          hintStyle: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF676767),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF1F2F3),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isPasswordValid
                                  ? Color(0xFFF1F2F3)
                                  : Colors.black, // 유효하지 않은 경우 검정색 테두리
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isPasswordValid
                                  ? Color(0xFFF1F2F3)
                                  : Colors.black, // 유효하지 않은 경우 검정색 테두리
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isPasswordValid
                                  ? Color(0xFFF1F2F3)
                                  : Colors.black, // 유효하지 않은 경우 검정색 테두리
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          suffixIcon: isPasswordValid
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '비밀번호를 다시 입력해주세요.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ),
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
                            fontSize: 10,
                            color: Color(0xFF676767),
                          ),
                          filled: true,
                          fillColor: Color(0xFFF1F2F3),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isPasswordMatch
                                  ? Color(0xFFF1F2F3)
                                  : Colors.black, // 일치하지 않을 경우 검정색 테두리
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isPasswordMatch
                                  ? Color(0xFFF1F2F3)
                                  : Colors.black, // 일치하지 않을 경우 검정색 테두리
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: isPasswordMatch
                                  ? Color(0xFFF1F2F3)
                                  : Colors.black, // 일치하지 않을 경우 검정색 테두리
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04),
                          suffixIcon: isPasswordMatch
                              ? null
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '비밀번호가 맞지 않습니다. 다시 입력해주세요.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenHeight * 0.015),
                                  ),
                                ),
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
                            : Color(0xFFD9D9D9),
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
    );
  }
}
