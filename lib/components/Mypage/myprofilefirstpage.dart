import 'package:flutter/material.dart';

import '../basic_frame_page.dart'; // 실제 경로는 프로젝트 구조에 따라 다를 수 있습니다.
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
    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 5),
            ProfileSection(),
            SizedBox(height: 10),
            SavedTravelCourses(), // RadarChart 추가
            SizedBox(height: 10),
            TravelDiary(),
            SizedBox(height: 10),
            WriteDiary(),
            SizedBox(height: 10),

            // 버튼 아래 여백 추가// 여행 상세분석 추가
          ],
        ),
      ),
    );
  }
}
