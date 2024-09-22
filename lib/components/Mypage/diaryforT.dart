// lib/pages/diaryforT.dart

import 'dart:io';
import 'package:flutter/material.dart';
import '../map/api.dart';
import '../start/basicframe3.dart';
import 'uploadmypictures.dart';
import 'hexagonalchart.dart';
import 'coursefeedback.dart';
import '../Mypage/mypagemodelforT.dart';
import 'package:http/http.dart' as http;


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
                  print('저장된 데이터: ${diary.toJson()}');
                  print(diary.priceSatisfaction);
                  uploadDiary(
                    courseName: diary.courseName,
                    travelDate: diary.travelDate,
                    nature: 'T',
                    transportationSatisfaction: diary.transportationSatisfaction != null ? diary.transportationSatisfaction : 0,
                    sightseeingSatisfaction: diary.sightseeingSatisfaction != null ? diary.sightseeingSatisfaction : 0,
                    accommodationSatisfaction: diary.accommodationSatisfaction != null ? diary.accommodationSatisfaction : 0,
                    priceSatisfaction: diary.priceSatisfaction != null ? diary.priceSatisfaction : 0,
                    environmentSatisfaction: diary.environmentSatisfaction!= null ? diary.environmentSatisfaction : 0,
                    foodSatisfaction: diary.foodSatisfaction != null ? diary.foodSatisfaction : 0,
                    satisfactionFeedback: diary.satisfactionFeedback,
                    keepFeedback: diary.keepFeedback,
                    travelPhotos: diary.travelPhotos,);
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

Future<void> uploadDiary({
  required String courseName,
  required DateTime travelDate,
  required String nature,
  int? transportationSatisfaction,
  int? sightseeingSatisfaction,
  int? accommodationSatisfaction,
  int? priceSatisfaction,
  int? environmentSatisfaction,
  int? foodSatisfaction,
  String? satisfactionFeedback,
  String? keepFeedback,
  String? positiveFeedback,
  String? improvementFeedback,
  String? finalThoughts,
  List<String>? happyEmotions,
  List<String>? satisfiedEmotions,
  List<String>? comfortableEmotions,
  List<String>? surprisedEmotions,
  List<String>? disappointedEmotions,
  List<String>? sadEmotions,
  List<String>? angryEmotions,
  List<String>? travelPhotos,
}) async {
  Map<String, String> fields = {
    'courseName': courseName,
    'travelDate': travelDate.toIso8601String(),
    'nature': nature,
  };
  if (transportationSatisfaction != null) {
    fields['transportationSatisfaction'] = transportationSatisfaction.toString();
  }
  if (sightseeingSatisfaction != null) {
    fields['sightseeingSatisfaction'] = sightseeingSatisfaction.toString();
  }
  if (accommodationSatisfaction != null) {
    fields['accommodationSatisfaction'] = accommodationSatisfaction.toString();
  }
  if (priceSatisfaction != null) {
    fields['priceSatisfaction'] = priceSatisfaction.toString();
  }
  if (environmentSatisfaction != null) {
    fields['environmentSatisfaction'] = environmentSatisfaction.toString();
  }
  if (foodSatisfaction != null) {
    fields['foodSatisfaction'] = foodSatisfaction.toString();
  }
  if (satisfactionFeedback != null) {
    fields['satisfactionFeedback'] = satisfactionFeedback;
  }
  if (keepFeedback != null) {
    fields['keepFeedback'] = keepFeedback;
  }
  if (positiveFeedback != null) {
    fields['positiveFeedback'] = positiveFeedback;
  }
  if (improvementFeedback != null) {
    fields['improvementFeedback'] = improvementFeedback;
  }
  if (finalThoughts != null) {
    fields['finalThoughts'] = finalThoughts;
  }

  if (happyEmotions != null) {
    fields['happyEmotions'] = happyEmotions.join(',');
  }
  if (satisfiedEmotions != null) {
    fields['satisfiedEmotions'] = satisfiedEmotions.join(',');
  }
  if (comfortableEmotions != null) {
    fields['comfortableEmotions'] = comfortableEmotions.join(',');
  }
  if (surprisedEmotions != null) {
    fields['surprisedEmotions'] = surprisedEmotions.join(',');
  }
  if (disappointedEmotions != null) {
    fields['disappointedEmotions'] = disappointedEmotions.join(',');
  }
  if (sadEmotions != null) {
    fields['sadEmotions'] = sadEmotions.join(',');
  }
  if (angryEmotions != null) {
    fields['angryEmotions'] = angryEmotions.join(',');
  }

  List<File> temporaryFiles = [];

  if (travelPhotos != null && travelPhotos.isNotEmpty) {
    for (String photoPath in travelPhotos) {
      File photoFile = File(photoPath);
      if (await photoFile.exists()) {
        temporaryFiles.add(photoFile);
      }
    }
  }

  try {
    final response = await ApiService.postMultipart(
      '/diary',
      fields: fields,
      files: temporaryFiles,
    );

    if (response.statusCode == 200) {
      print('Upload successful');
      final responseData = await http.Response.fromStream(response);
      print('Response data: ${responseData.body}');
    } else {
      print('Upload failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during upload: $e');
  } finally {
    for (var file in temporaryFiles) {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}
