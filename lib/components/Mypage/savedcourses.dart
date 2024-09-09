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
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '저장한 코스가 없습니다',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
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
