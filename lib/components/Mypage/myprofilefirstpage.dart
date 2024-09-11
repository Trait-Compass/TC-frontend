import 'package:flutter/material.dart';
import '../Mypage/myprofile.dart';
import '../Mypage/savedcourses.dart';
import '../Mypage/traveldiary.dart';
import '../Mypage/writemydiary.dart';

void main() {
  runApp(MaterialApp(
    home: Mypage(),
  ));
}

class Mypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 5),
            ProfileSection(), // 프로필 섹션 위젯
            SizedBox(height: 10),
            SavedTravelCourses(), // 저장된 여행 코스 위젯
            SizedBox(height: 10),
            TravelDiary(), // 여행 다이어리 위젯
            SizedBox(height: 10),
            WriteDiary(), // 다이어리 작성 위젯
            SizedBox(height: 10),

            // 버튼 아래 여백 추가 및 여행 상세 분석 추가
          ],
        ),
      ),
    );
  }
}
