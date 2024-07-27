import 'package:flutter/material.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _mbtiController = TextEditingController();
  String _gender = '';
  bool isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _nicknameController.text.isNotEmpty &&
          _mbtiController.text.isNotEmpty &&
          _gender.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _nicknameController.addListener(_updateButtonState);
    _mbtiController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _mbtiController.dispose();
    super.dispose();
  }

  void _start() {
    // 시작 버튼 클릭 시 로직을 여기에 추가합니다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              '시작: ${_nicknameController.text}, ${_mbtiController.text}, $_gender')),
    );
  }

  void _checkDuplicate() {
    // 닉네임 중복 확인 로직을 여기에 추가합니다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('중복 확인')),
    );
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
                    '회원정보 설정',
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
                        '닉네임',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 47,
                              child: TextField(
                                controller: _nicknameController,
                                decoration: InputDecoration(
                                  hintText: '닉네임을 입력해주세요',
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
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 60,
                            height: 47,
                            child: ElevatedButton(
                              onPressed: _checkDuplicate,
                              child: Center(
                                child: Text(
                                  '중복 확인',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'MBTI',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 47,
                                  child: TextField(
                                    controller: _mbtiController,
                                    decoration: InputDecoration(
                                      hintText: 'MBTI를 설정해주세요',
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF676767),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFF1F2F3),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFFF1F2F3), // 테두리 색상을 변경합니다.
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFFF1F2F3), // 테두리 색상을 변경합니다.
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(
                                              0xFFF1F2F3), // 테두리 색상을 변경합니다.
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '성별',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  height: 47,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '남성',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Radio<String>(
                                        value: '남성',
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
                                      SizedBox(width: 5),
                                      Text(
                                        '여성',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Radio<String>(
                                        value: '여성',
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
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 192,
                      height: 47,
                      child: ElevatedButton(
                        onPressed: isButtonEnabled ? _start : null,
                        child: Text(
                          '시작',
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
