// lib/pages/diaryforT.dart

import 'package:flutter/material.dart';
import '../start/basicframe3.dart';
import 'uploadmypictures.dart';
import 'hexagonalchart.dart';
import 'coursefeedback.dart';
import '../Mypage/mypagemodelforT.dart';

void main() {
  runApp(MaterialApp(
    home: DiaryforT(),
  ));
}

class DiaryforT extends StatefulWidget {
  @override
  _DiaryforTState createState() => _DiaryforTState();
}

class _DiaryforTState extends State<DiaryforT> {
  // TravelDiary 모델 인스턴스 생성
  TravelDiary diary = TravelDiary(
    courseName: '',
    travelDate: DateTime.now(),
    nature: '일기 종류 예시',
  );

  @override
  Widget build(BuildContext context) {
    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 5),
            TravelDetailPage(diary: diary), // 모델 전달
            SizedBox(height: 10),
            RadarChartWidget(diary: diary), // 모델 전달
            SizedBox(height: 40),
            TravelDetailAnalysisSection(diary: diary), // 모델 전달
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 저장 로직 구현
                  // 예: diary.toJson()을 사용하여 서버에 전송하거나 로컬 저장소에 저장
                  print('저장된 데이터: ${diary.toJson()}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEAEAEA),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '저장하기',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
