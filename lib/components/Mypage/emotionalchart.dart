import 'package:flutter/material.dart';

class EmotionChart extends StatelessWidget {
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
      'feelings': ['감탄', '경이로움', '신비로움', '깜짝 놀람', '새로운 발견']
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 300,
        child: Table(
          border: TableBorder.all(color: Colors.black),
          children: [
            TableRow(
              children: emotions.map((emotion) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
              children: emotions.map((emotion) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: emotion['feelings'].map<Widget>((feeling) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          feeling,
                          style: TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
