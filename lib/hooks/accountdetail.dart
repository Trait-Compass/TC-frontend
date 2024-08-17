import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserInfoScreen extends StatefulWidget {
  final String id; // 사용자가 입력한 id
  final String password; // 사용자가 입력한 password

  UserInfoScreen({required this.id, required this.password});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  String _mbti = ''; // MBTI 선택을 저장하는 변수
  String _gender = ''; // 성별을 저장하는 변수 ("M" 또는 "F")
  bool isButtonEnabled = false; // 시작 버튼 활성화 상태를 저장하는 변수

  final List<String> _mbtiList = [
    'INTJ',
    'INTP',
    'ENTJ',
    'ENTP',
    'INFJ',
    'INFP',
    'ENFJ',
    'ENFP',
    'ISTJ',
    'ISFJ',
    'ESTJ',
    'ESFJ',
    'ISTP',
    'ISFP',
    'ESTP',
    'ESFP'
  ]; // 16가지 MBTI 목록

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _nicknameController.text.isNotEmpty &&
          _mbti.isNotEmpty &&
          _gender.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _submitUserInfo() async {
    final String nickname = _nicknameController.text;
    final String mbti = _mbti;
    final String gender = _gender;
    final bool isOauth = true;

    // 로그를 추가하여 성별 값이 제대로 설정되는지 확인합니다.
    print('Submitting user info: Gender = $gender');

    final response = await http.post(
      Uri.parse('https://www.traitcompass.store/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': widget.id,
        'password': widget.password,
        'nickname': nickname,
        'mbti': mbti,
        'gender': gender,
        'isOauth': isOauth,
      }),
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      print('User info submitted successfully.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원정보가 성공적으로 제출되었습니다.')),
      );
    } else {
      print('Failed to submit user info. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원정보 제출에 실패했습니다.')),
      );
    }
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
                  '회원정보 설정',
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
                      '닉네임',
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
                              controller: _nicknameController,
                              decoration: InputDecoration(
                                hintText: '닉네임을 입력해주세요',
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MBTI',
                                style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: screenHeight * 0.06,
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F2F3),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color(0xFFF1F2F3),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _mbti.isEmpty ? null : _mbti,
                                  hint: Text(
                                    'MBTI를 설정해주세요',
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.017,
                                        color: Color(0xFF676767)),
                                  ),
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: screenHeight * 0.03,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: screenHeight * 0.017),
                                  underline: Container(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _mbti = newValue!;
                                      _updateButtonState();
                                    });
                                  },
                                  items: _mbtiList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '성별',
                                style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: screenHeight * 0.06,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '남성',
                                      style: TextStyle(
                                          fontSize: screenHeight * 0.015),
                                    ),
                                    Radio<String>(
                                      value: 'M',
                                      groupValue: _gender,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _gender = value!;
                                          _updateButtonState();
                                          // 로그 추가
                                          print('남성임');
                                        });
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    SizedBox(width: screenWidth * 0.01),
                                    Text(
                                      '여성',
                                      style: TextStyle(
                                          fontSize: screenHeight * 0.015),
                                    ),
                                    Radio<String>(
                                      value: 'F',
                                      groupValue: _gender,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _gender = value!;
                                          _updateButtonState();
                                          // 로그 추가
                                          print('여성임');
                                        });
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled
                          ? _submitUserInfo
                          : null, // 버튼 클릭 시 서버에 정보 전송
                      child: Text(
                        '시작',
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonEnabled
                            ? Colors.black.withOpacity(0.28)
                            : Color(0xFFD9D9D9), // 활성화/비활성화 상태에 따른 색상 설정
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
