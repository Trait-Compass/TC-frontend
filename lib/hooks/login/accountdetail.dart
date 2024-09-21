import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:untitled/components/basicframe.dart';
import 'dart:convert';
import '../../components/mbtitest/MBTItestpage.dart';
import '../../components/mbti_selection_page.dart';

import 'package:untitled/components/start/basicframe3.dart';

class UserInfoScreen extends StatefulWidget {
  final String id;
  final String password;

  UserInfoScreen({required this.id, required this.password});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  String _mbti = '';
  String _gender = '';
  bool isButtonEnabled = false;
  bool isnicknameUnique = false;

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
  ];

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _nicknameController.text.isNotEmpty &&
          _mbti.isNotEmpty &&
          _gender.isNotEmpty &&
          isnicknameUnique;
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
    final bool isOauth = false;

    final Map<String, dynamic> requestBody = {
      'id': widget.id,
      'password': widget.password,
      'nickname': nickname,
      'mbti': mbti,
      'gender': gender,
      'isOauth': isOauth,
    };

    print('Request Body: $requestBody'); // 요청 본문을 출력하여 디버깅

    final response = await http.post(
      Uri.parse('https://www.traitcompass.store/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    print('Response Status Code: ${response.statusCode}'); // 상태 코드 출력
    print('Response Body: ${response.body}'); // 응답 본문 출력하여 디버깅

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원정보가 성공적으로 제출되었습니다.')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BasicFramePage(body: MBTISelectionPage()),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('회원정보 제출에 실패했습니다. 상태 코드: ${response.statusCode}')),
      );
    }
  }

  Future<void> _checkDuplicateNickname() async {
    final String nickname = _nicknameController.text;

    final response = await http.get(
        Uri.parse('https://www.traitcompass.store/user/nickname/$nickname'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final bool isNicknameTaken = responseData['result'];

      if (isNicknameTaken) {
        setState(() {
          isnicknameUnique = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미 사용 중인 닉네임입니다.')),
        );
      } else {
        setState(() {
          isnicknameUnique = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('사용 가능한 닉네임입니다.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('닉네임 중복 확인에 실패했습니다.')),
      );
    }

    _updateButtonState();
  }

  void _navigateToMBTITest() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MBTItestselection()),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MBTItestselection(),
      ),
    );
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
          padding: const EdgeInsets.all(16.0),
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
                                  fontSize: screenHeight * 0.018,
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
                                    horizontal: screenWidth * 0.04,
                                    vertical: screenHeight * 0.015),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Container(
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: _checkDuplicateNickname,
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
                                        fontSize: screenHeight * 0.018,
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
                              SizedBox(height: screenHeight * 0.01),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      '아직 내 MBTI를 모른다면',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[600]),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Expanded(
                                    flex: 2,
                                    child: TextButton(
                                      onPressed: _navigateToMBTITest,
                                      child: Text(
                                        '내 MBTI 알아보러 가기         \n               GO',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                ],
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
                                      'M',
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
                                        });
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                    SizedBox(width: 0),
                                    Text(
                                      'F',
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
                ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () {
                          _submitUserInfo(); // 회원정보 제출 후
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BasicFrame1Page(
                                body: MBTISelectionPage(),
                              ),
                            ), // 페이지 이동
                          );
                        }
                      : null,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
