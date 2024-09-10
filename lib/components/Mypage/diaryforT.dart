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
    // final double screenHeight = MediaQuery.of(context).size.height;
    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 5),
            TravelDetailPage(),
            SizedBox(height: 10),
            RadarChartWidget(), // RadarChart 추가
            SizedBox(height: 40),
            SizedBox(height: 5),
            TravelDetailAnalysisSection(),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xEAEAEA), // 버튼 색상 설정
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // 버튼 패딩 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 버튼 모서리 둥글게 설정
                  ),
                ),
                child: Text(
                  '저장하기',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black), // 텍스트 스타일 설정
                ),
              ),
            ),

            SizedBox(height: 20), // 버튼 아래 여백 추가// 여행 상세분석 추가
          ],
        ),
      ),
    );
  }
}
