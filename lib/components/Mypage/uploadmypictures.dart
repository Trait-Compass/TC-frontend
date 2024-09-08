import 'package:flutter/material.dart';

class TravelDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // 전체 패딩 추가
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5), // Divider로부터 10만큼 간격 추가
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // 두 박스를 양 끝으로 정렬
            children: [
              Container(
                width: 160, // 각 박스의 너비를 화면 절반으로 설정
                height: 22, // 박스의 높이
                decoration: BoxDecoration(
                  color: Color(0xFFEAEAEA),
                  borderRadius: BorderRadius.circular(5),
                ), // 회색 배경색
                child: Center(
                  child: Text(
                    '코스 이름:', // 박스 안의 텍스트
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 160, // 각 박스의 너비를 화면 절반으로 설정
                height: 22, // 박스의 높이
                decoration: BoxDecoration(
                  color: Color(0xFFEAEAEA),
                  borderRadius: BorderRadius.circular(5),
                ), // 회색 배경색
                child: Center(
                  child: Text(
                    '여행 날짜:', // 박스 안의 텍스트
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // 회색 박스 밑에 10만큼 간격 추가
          Text('여행 사진 업로드',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            height: 150, // 박스의 높이를 더 높게 설정해서 텍스트와 스크롤바를 포함
            child: Center(
              child: Column(
                children: [
                  Text(
                    '사진 기록', // 사진 박스의 중심에 맞추어진 텍스트
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5), // 텍스트와 사진 박스 사이의 간격
                  Container(
                    width: 132, // 박스의 너비
                    height: 100, // 박스의 높이
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          // 버튼 클릭 시 수행할 동작
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Color(0xFFE0E0E0)), // 회색 배경색 설정
                          minimumSize: WidgetStateProperty.all<Size>(
                              Size(85, 25)), // 버튼 크기 설정
                        ),
                        child: Text(
                          '사진 추가하기',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ), // 버튼 텍스트 크기
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
        ],
      ),
    );
  }
}
