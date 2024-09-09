import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart'; // dotted_border 패키지 임포트

class TravelDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '여행 일기장',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          // 점선 박스
          DottedBorder(
            color: Colors.black, // 점선 색상
            strokeWidth: 1, // 점선 두께
            borderType: BorderType.RRect, // 둥근 모서리
            radius: Radius.circular(10), // 모서리 반경
            dashPattern: [4, 2], // 점선 패턴: 5 길이의 점선, 3 길이의 공백
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '작성된 일기가 없습니다',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
