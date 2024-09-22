// lib/pages/emotionalchart.dart

import 'package:flutter/material.dart';
import '../Mypage/mypagemodelforF.dart';

class EmotionChart extends StatefulWidget {
  final TravelDiaryEmotion diaryEmotion; // 모델 인스턴스 전달

  EmotionChart({required this.diaryEmotion});

  @override
  _EmotionChartState createState() => _EmotionChartState();
}

class _EmotionChartState extends State<EmotionChart> {
  final List<Map<String, dynamic>> emotions = [
    {
      'emoji': '😊',
      'title': '행복',
      'feelings': ['기쁨', '재미있음', '즐거움', '활기참', '황홀함', '감사함']
    },
    {
      'emoji': '🙂',
      'title': '만족',
      'feelings': ['성취감', '감동적임', '안정감', '만족감', '흐뭇함', '보람참']
    },
    {
      'emoji': '😌',
      'title': '편안',
      'feelings': ['안락함', '따뜻함', '평화로움', '여유로움', '휴식']
    },
    {
      'emoji': '😮',
      'title': '놀람',
      'feelings': ['감탄', '경이로움', '신비로움', '깜짝 놀람', '새로운\n 발견']
    },
    {
      'emoji': '😞',
      'title': '실망',
      'feelings': ['아쉬움', '허탈함', '후회', '좌절', '답답함', '막막함']
    },
    {
      'emoji': '😭',
      'title': '슬픔',
      'feelings': ['눈물', '우울함', '절망감', '침울함', '쓸쓸함']
    },
    {
      'emoji': '😡',
      'title': '화남',
      'feelings': ['짜증', '분노', '억울함', '어이없음', '불쾌함']
    },
  ];

  List<List<bool>> _isSelected;

  _EmotionChartState()
      : _isSelected = List.generate(
          7,
          (index) => List.generate(
            6,
            (_) => false,
          ),
        );

  // 선택된 감정들을 모델에 저장하는 함수
  void _saveToModel() {
    widget.diaryEmotion.happyEmotions = _getSelectedFeelings(0);
    widget.diaryEmotion.satisfiedEmotions = _getSelectedFeelings(1);
    widget.diaryEmotion.comfortableEmotions = _getSelectedFeelings(2);
    widget.diaryEmotion.surprisedEmotions = _getSelectedFeelings(3);
    widget.diaryEmotion.disappointedEmotions = _getSelectedFeelings(4);
    widget.diaryEmotion.sadEmotions = _getSelectedFeelings(5);
    widget.diaryEmotion.angryEmotions = _getSelectedFeelings(6);
  }

  // 선택된 세부 감정들을 추출하는 함수
  List<String> _getSelectedFeelings(int emotionIndex) {
    List<String> selectedFeelings = [];
    for (int i = 0; i < emotions[emotionIndex]['feelings'].length; i++) {
      if (_isSelected[emotionIndex][i]) {
        selectedFeelings.add(emotions[emotionIndex]['feelings'][i]);
      }
    }
    return selectedFeelings;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '여행 감정 차트',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Center(
            child: Container(
              width: double.infinity,
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: emotions.map((emotion) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Text(
                              emotion['emoji'],
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 4),
                            Text(
                              emotion['title'],
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  TableRow(
                    children: emotions.asMap().entries.map((entry) {
                      int emotionIndex = entry.key;
                      Map<String, dynamic> emotion = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: emotion['feelings']
                            .asMap()
                            .entries
                            .map<Widget>((feelingEntry) {
                          int feelingIndex = feelingEntry.key;
                          String feeling = feelingEntry.value;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSelected[emotionIndex][feelingIndex] =
                                      !_isSelected[emotionIndex][feelingIndex];
                                  _saveToModel(); // 모델 업데이트
                                });
                              },
                              child: IntrinsicHeight(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: _isSelected[emotionIndex]
                                            [feelingIndex]
                                        ? Colors.grey[300]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      feeling,
                                      style: TextStyle(fontSize: 9),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
