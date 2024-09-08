import 'package:flutter/material.dart';

class EmotionChart extends StatefulWidget {
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
      'title': '편안함',
      'feelings': ['안락함', '따뜻함', '평화로움', '여유로움', '휴식']
    },
    {
      'emoji': '😮',
      'title': '놀람',
      'feelings': ['감탄', '경이로움', '신비로움', '깜짝놀람', '새로운\n 발견']
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

  // 감정의 클릭 상태를 추적하기 위한 리스트 (각 열의 feelings 길이에 맞게 초기화)
  List<List<bool>> _isSelected;

  _EmotionChartState()
      : _isSelected = List.generate(
          7,
          (index) => List.generate(
            6,
            (_) => false,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20), // 전체 화면에서 20의 패딩 추가
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
        children: [
          // 화면의 맨 위에 텍스트 추가
          Text(
            '여행 감정 차트',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5), // 텍스트와 표 사이의 간격 추가
          Center(
            child: Container(
              width: double.infinity, // 가로로 꽉 채움
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: emotions.map((emotion) {
                      return Padding(
                        padding: const EdgeInsets.all(8), // 감정 박스의 패딩 설정
                        child: Column(
                          children: [
                            Text(
                              emotion['emoji'],
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(height: 4),
                            Text(
                              emotion['title'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  TableRow(
                    children: emotions.asMap().entries.map((entry) {
                      int emotionIndex = entry.key; // 감정 인덱스
                      Map<String, dynamic> emotion = entry.value; // 감정 데이터

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: emotion['feelings']
                            .asMap()
                            .entries
                            .map<Widget>((feelingEntry) {
                          int feelingIndex = feelingEntry.key; // 감정 느낌 인덱스
                          String feeling = feelingEntry.value; // 감정 느낌

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 4), // 세로와 가로 간격을 동시에 조절할 수 있는 패딩
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSelected[emotionIndex][feelingIndex] =
                                      !_isSelected[emotionIndex]
                                          [feelingIndex]; // 클릭 상태 변경
                                });
                              },
                              child: IntrinsicHeight(
                                // 텍스트 길이에 따라 박스 크기를 자동 조절
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4), // 내부 여백 추가
                                  decoration: BoxDecoration(
                                    color: _isSelected[emotionIndex]
                                            [feelingIndex]
                                        ? Colors.grey[300]
                                        : Colors.white, // 클릭 시 색상 변경
                                    borderRadius:
                                        BorderRadius.circular(15), // 모서리 둥글게
                                  ),
                                  child: Center(
                                    child: Text(
                                      feeling,
                                      style: TextStyle(fontSize: 13),
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
