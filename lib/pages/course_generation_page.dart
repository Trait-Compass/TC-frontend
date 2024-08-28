import 'package:flutter/material.dart';
import 'dart:async';
import 'result_page.dart';
import 'BestCourseTop3.dart';
import 'GyeongNamRecommend.dart';
import '../components/basic_frame_page.dart'; // BasicFramePage를 임포트합니다.

class CourseGenerationPage extends StatelessWidget {
  final String mbti;

  CourseGenerationPage({required this.mbti});

  @override
  Widget build(BuildContext context) {
    // 3초 후에 자동으로 다음 페이지로 이동
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(mbti: mbti),
        ),
      );
    });

    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: Color(0xFFE4E4E4),
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Image.asset('assets/animation.png', height: 50),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '코스를 생성중이에요!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'MBTI 맞춤형 간단 추천 코스',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset('assets/img.png'),
                    SizedBox(height: 10),
                    Text(
                      '생성중...',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            BestCourseTop3(), // BestcourseTop3.dart 위젯 추가
            SizedBox(height: screenHeight * 0.02),
            GyeongNamRecommend(), // GyeongNamRecommend.dart 위젯 추가
          ],
        ),
      ),
    );
  }
}
