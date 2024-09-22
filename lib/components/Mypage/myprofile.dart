import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/components/map/api.dart';
import 'package:untitled/components/mbtitest/MBTItestpage.dart';
import 'package:untitled/components/start/onboarding.dart';
import 'package:untitled/hooks/login/information.dart';

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiService.fetchUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 프로필 데이터를 가져오지 못한 경우
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  '프로필 데이터를 가져오지 못했어요 \n MBTI를 등록해주세요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MBTItestselection(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEDEDED), 
                    foregroundColor: Colors.black, 
                  ),
                  child: Text(
                    'MBTI 테스트 하러가기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, 
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        } else if (!snapshot.hasData) {
          return Center(child: Text('프로필 정보가 없습니다.'));
        } else {
          final profileData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '나의 프로필',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Theme(
                      data: Theme.of(context).copyWith(
                        popupMenuTheme: PopupMenuThemeData(
                          color: Colors.white,
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        icon: Icon(Icons.settings),
                        onSelected: (value) {
                          if (value == '회원탈퇴') {
                            _showWithdrawalDialog(context);
                          } else if (value == '이용약관') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TermsAndConditionsPage(),
                              ),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: '회원탈퇴',
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.black),
                                SizedBox(width: 10),
                                Text('회원탈퇴'),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: '이용약관',
                            child: Row(
                              children: [
                                Icon(Icons.settings, color: Colors.black),
                                SizedBox(width: 10),
                                Text('이용약관'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFEDEDED),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      Container(
                        height: 110,
                        width: 70,
                        child: Image.asset(
                          'assets/image.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 55,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: Text(
                                    profileData['mbti'] ?? "", 
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD07C58),
                                    borderRadius: BorderRadius.circular(12.5),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: Text(
                                    _addLineBreakAfterFiveChars(
                                        profileData['mbtiDescription'][0] ?? ""),
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD07C58),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 49,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: Text(
                                    profileData['nickname'] ?? "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 70,
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          profileData['mbtiDescription'][1] ?? "",
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD07C58).withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12.5),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Container(
                                    height: 70,
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "❤️ 찰떡궁합 ",
                                              style: GoogleFonts.notoColorEmoji(
                                                textStyle: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              profileData['mbtiMatchups']['chalTeok'] ?? "",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "😅 환장궁합 ",
                                              style: GoogleFonts.notoColorEmoji(
                                                textStyle: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              profileData['mbtiMatchups']['hwanJang'] ?? "",
                                              style: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD07C58).withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );

  }

  // 문자열에서 5자 뒤에 줄바꿈을 추가하는 메서드
  String _addLineBreakAfterFiveChars(String text) {
    if (text.length > 9) {
      return text.substring(0, 9) + '\n' + text.substring(9);
    }
    return text;
  }

void _showWithdrawalDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), 
        ),
        content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '탈퇴 하시겠습니까?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      bool success = await _withdrawMembership();

                      if (success) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('회원 탈퇴가 완료되었습니다.')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingPage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('다시 시도해주세요.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                    ),
                    child: Text(
                      '네 탈퇴 할게요',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                    ),
                    child: Text(
                      '아니요 탈퇴 안할게요',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// 회원탈퇴 로직을 처리하는 메서드
Future<bool> _withdrawMembership() async {
  try {
    bool response = await ApiService.deleteUser();

    if (response) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error in _withdrawMembership: $e');
    return false;
  }
}
}

