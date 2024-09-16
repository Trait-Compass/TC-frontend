import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/hooks/MBTItestpage.dart';
import 'package:untitled/components/map/api.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';

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
                Text(
                  '프로필 데이터를 가져오지 못했습니다.\nMBTI 검사를 진행해주세요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
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
                  child: Text('MBTI 검사 시작하기'),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData) {
          return Center(child: Text('프로필 정보가 없습니다.'));
        } else {
          // 데이터를 정상적으로 가져온 경우 위젯 빌드
          final profileData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나의 프로필',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
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
                          'assets/istj.png',
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
                                    profileData['mbti'] ?? "", // API에서 가져온 MBTI
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
                                    _addLineBreakAfterFiveChars(profileData['mbtiDescription'][0] ?? ""),
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
}
