import 'package:flutter/material.dart';
import 'MBTIselection.dart'; // MBTIselection.dart 파일을 import
import 'MBTItestpage.dart'; // MBTItestpage.dart 파일을 import

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _mbtiController = TextEditingController();
  String _gender = '';
  bool isButtonEnabled = false;
  bool isMBTISelectionVisible = false;
  bool isDuplicateCheckEnabled = false;

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = _nicknameController.text.isNotEmpty &&
          _mbtiController.text.isNotEmpty &&
          _gender.isNotEmpty;
      isDuplicateCheckEnabled = _nicknameController.text.isNotEmpty;
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

  void _checkDuplicate() {
    // 닉네임 중복 확인 로직을 여기에 추가합니다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '중복확인 되었습니다',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white), // 텍스트 색상 설정
        ),
        backgroundColor: Color(0xFFE0E0E0),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20.0),
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void _goToMBTItestpage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MBTItestpage()),
    );
  }

  void _showMBTISelection() {
    setState(() {
      isMBTISelectionVisible = !isMBTISelectionVisible;
    });
  }

  void _selectMBTI(String mbti) {
    setState(() {
      _mbtiController.text = mbti;
      isMBTISelectionVisible = false;
    });
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
                  'assets/mbtilogo.jpg', // 여기에 로고 이미지의 경로를 넣으세요.
                  height: screenHeight * 0.1, // 이미지의 높이를 적절히 조절하세요.
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Container(
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: isDuplicateCheckEnabled
                                ? _checkDuplicate
                                : null,
                            child: Center(
                              child: Text(
                                '중복 확인',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.017,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDuplicateCheckEnabled
                                  ? Colors.black.withOpacity(0.28)
                                  : Color(0xFFE0E0E0), // 비활성화 색상 추가
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                  color: isDuplicateCheckEnabled
                                      ? Colors.black.withOpacity(0.28)
                                      : Color(0xFFE0E0E0),
                                ),
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
                              GestureDetector(
                                onTap: _showMBTISelection,
                                child: Container(
                                  height: screenHeight * 0.06,
                                  width: screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F2F3),
                                    border: Border.all(
                                      color: Color(0xFFF1F2F3),
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04),
                                  child: Text(
                                    _mbtiController.text.isEmpty
                                        ? 'MBTI를 설정해주세요'
                                        : _mbtiController.text,
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.017,
                                      color: _mbtiController.text.isEmpty
                                          ? Color(0xFF676767)
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              if (isMBTISelectionVisible)
                                Column(
                                  children: [
                                    SizedBox(height: screenHeight * 0.01),
                                    Container(
                                      height: screenHeight * 0.24, // 4개의 박스 높이
                                      child: MBTISelection(
                                        onSelectMBTI: _selectMBTI,
                                        boxHeight: screenHeight * 0.06,
                                        boxWidth: double.infinity,
                                        textStyle: TextStyle(
                                          fontSize: screenHeight * 0.017,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(
                                    right:
                                        screenWidth * 0.04), // 오른쪽 정렬을 위한 패딩 추가
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '아직 내 MBTI를 모른다면?',
                                      style: TextStyle(
                                          fontSize: screenHeight * 0.015,
                                          color: Color(0xFF676767)),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '내 MBTI 알아보러 가기',
                                          style: TextStyle(
                                              fontSize: screenHeight * 0.015,
                                              color: Color(0xFF676767)),
                                        ),
                                        GestureDetector(
                                          onTap: _goToMBTItestpage,
                                          child: Text(
                                            ' GO',
                                            style: TextStyle(
                                              fontSize: screenHeight * 0.015,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                    SizedBox(width: screenWidth * 0.01),
                                    Text(
                                      '여성',
                                      style: TextStyle(
                                          fontSize: screenHeight * 0.015),
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
                SizedBox(height: screenHeight * 0.03),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.06,
                    child: ElevatedButton(
                      onPressed:
                          isButtonEnabled ? () {} : null, // 여기서 아무것도 하지 않음
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
    );
  }
}
