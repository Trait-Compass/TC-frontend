import 'package:flutter/material.dart';
import '../Mypage/emotionalchart.dart';
import '../Mypage/uploadmypictures.dart'; // 정확한 경로로 수정 필요
import '../Mypage/emotionalfeedback.dart';

void main() {
  runApp(MaterialApp(
    home: DiaryforF(),
  ));
}

class DiaryforF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 기본 화면 구조를 Scaffold로 설정
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 5),
            TravelDetailPage(), // 여행 상세 페이지 위젯
            EmotionChart(), // 감정 차트 위젯
            TravelFeelingAnalysisSection(), // 감정 분석 섹션 위젯
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 저장 버튼 클릭 시 수행할 동작 추가
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xEAEAEA), // 버튼 색상 설정
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // 버튼 패딩 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // 버튼 모서리 둥글게 설정
                  ),
                ),
                child: Text(
                  '저장하기',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black), // 텍스트 스타일 설정
                ),
              ),
            ),
            SizedBox(height: 20), // 버튼 아래 여백 추가
          ],
        ),
      ),
    );
  }
}
