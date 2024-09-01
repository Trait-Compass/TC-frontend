// diary_for_t.dart
import 'package:flutter/material.dart';
import '../basic_frame_page.dart';
import '../Mypage/uploadmypictures.dart'; // 정확한 경로로 수정 필요
import '../Mypage/hexagonalchart.dart'; // RadarChartWidget을 포함하고 있는 파일
import '../Mypage/coursefeedback.dart'; // 여행 상세분석 파일 임포트

void main() {
  runApp(MaterialApp(
    home: DiaryforT(),
  ));
}

class DiaryforT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 10),
            TravelDetailPage(),
            SizedBox(height: 40),
            RadarChartWidget(), // RadarChart 추가
            SizedBox(height: 40),
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 5),
            TravelDetailAnalysisSection(),
            SizedBox(height: 10), // 여행 상세분석 추가
          ],
        ),
      ),
    );
  }
}
