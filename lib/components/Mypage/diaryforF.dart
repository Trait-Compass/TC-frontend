// lib/pages/diaryforF.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'diaryforT.dart';
import 'emotionalchart.dart';
import 'uploadmypicturesforF.dart';
import 'emotionalfeedback.dart';
import '../start/basicframe3.dart';
import '../Mypage/mypagemodelforF.dart';

void main() {
  runApp(MaterialApp(
    home: DiaryforF(),
  ));
}

class DiaryforF extends StatefulWidget {
  @override
  _DiaryforFState createState() => _DiaryforFState();
}

class _DiaryforFState extends State<DiaryforF> {
  TravelDiaryEmotion diaryEmotion = TravelDiaryEmotion(
    courseName: '',
    travelDate: DateTime.now(),
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
            TravelDetailPage(diaryEmotion: diaryEmotion), // 모델 전달
            EmotionChart(diaryEmotion: diaryEmotion), // 모델 전달
            TravelFeelingAnalysisSection(diaryEmotion: diaryEmotion), // 모델 전달
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  uploadDiary(
                    courseName: diaryEmotion.courseName,
                    travelDate: diaryEmotion.travelDate,
                    nature: 'F',
                    happyEmotions: diaryEmotion.happyEmotions,
                    satisfiedEmotions: diaryEmotion.satisfiedEmotions,
                    comfortableEmotions: diaryEmotion.comfortableEmotions,
                    surprisedEmotions: diaryEmotion.surprisedEmotions,
                    disappointedEmotions: diaryEmotion.disappointedEmotions,
                    sadEmotions: diaryEmotion.sadEmotions,
                    angryEmotions: diaryEmotion.angryEmotions,
                    positiveFeedback: diaryEmotion.positiveFeedback,
                    improvementFeedback: diaryEmotion.negativeFeedback, //TODO
                    finalThoughts: diaryEmotion.finalThoughts,
                    travelPhotos: diaryEmotion.travelPhotos,
                  );
                  print('저장된 데이터: ${diaryEmotion.toJson()}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFEAEAEA),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
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
