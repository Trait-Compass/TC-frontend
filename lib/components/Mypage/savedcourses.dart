import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class SavedTravelCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '내가 저장한 여행 코스',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          // 점선 박스 추가
          DottedBorder(
            color: Colors.grey, // 점선 색상
            strokeWidth: 1, // 점선 두께
            borderType: BorderType.RRect, // 둥근 모서리
            radius: Radius.circular(10), // 모서리 반경
            dashPattern: [4, 2], // 점선 패턴: 5 길이의 점선, 3 길이의 공백
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '저장한 코스가 없습니다',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Text('코스 제작하기'),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          //
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Text('인기코스 보러가기'),
                      ),
                    ],
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
