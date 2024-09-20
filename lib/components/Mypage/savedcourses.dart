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
            color: Colors.black, // 점선 색상
            strokeWidth: 1, // 점선 두께
            borderType: BorderType.RRect, // 둥근 모서리
            radius: Radius.circular(10), // 모서리 반경
            dashPattern: [4, 2], // 점선 패턴
            child: Container(
              height: 160, // 점선 박스의 전체 높이
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
          SizedBox(height: 10),
          // 버튼을 점선 박스 아래로 이동
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // '코스 제작하기' 버튼 클릭 시의 동작 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEDEDED),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '코스 제작하기',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10), // 버튼 사이 간격 설정
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // '인기코스 보러가기' 버튼 클릭 시의 동작 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEDEDED),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '인기코스 보러가기',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
