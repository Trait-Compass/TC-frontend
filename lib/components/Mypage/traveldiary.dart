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
            dashPattern: [4, 2], // 점선 패턴
            child: Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // 첫 번째 흰색 박스
                      Container(
                        width: double.infinity, // 너비는 점선 박스와 동일
                        height: 160 / 2 - 5, // 높이는 점선 박스 절반보다 5만큼 작음
                        decoration: BoxDecoration(
                          color: Colors.white, // 배경색 흰색으로 설정
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            // 테두리 검정색 설정
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      // '남해군' 텍스트를 흰색 박스 오른쪽 하단에 배치
                      Positioned(
                        bottom: 8, // 하단 여백
                        right: 8, // 오른쪽 여백
                        child: Text(
                          '남해군',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 두 박스 사이 간격을 위한 Container 삽입
                  Container(
                    height: 10, // 간격을 10만큼 설정
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
