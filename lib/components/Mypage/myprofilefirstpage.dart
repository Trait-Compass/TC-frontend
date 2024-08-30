import 'package:flutter/material.dart';
import '../basic_frame_page.dart'; // 가정한 경로, 실제 import 경로에 맞게 수정 필요

void main() {
  runApp(MaterialApp(
    home: Mypage(),
  ));
}

class Mypage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final grayBoxHeight = screenHeight * 0.15; // 회색 박스의 높이
    final whiteBoxHeight = screenHeight * 0.18; // 흰색 박스의 높이
    final lastBoxHeight = screenHeight * 0.15; // 마지막 회색 박스의 높이

    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(
              color: Color(0xFFE4E4E4),
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: 10), // Divider와 회색 박스 사이의 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: grayBoxHeight,
                decoration: BoxDecoration(
                  color: Color(0xFFEAEAEA),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 5), // 회색 박스와 텍스트 사이의 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), // 텍스트 위치 조정
              child: Text(
                '내가 저장한 여행 코스',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5), // 텍스트와 흰색 박스 사이의 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: whiteBoxHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                    )),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '여행 일기장',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5), // 텍스트와 흰색 박스 사이의 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: whiteBoxHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                    )),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '일기 작성하기',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5), // 텍스트와 흰색 박스 사이의 간격
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 40 - 10) / 2,
                    height: lastBoxHeight,
                    padding: EdgeInsets.only(left: 20), // 여백 추가
                    alignment: Alignment.centerLeft, // 텍스트를 세로 중심 왼쪽에 정렬
                    child: Text(
                      'T',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E4E4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(width: 10), // 두 컨테이너 사이의 간격
                  Container(
                    width: (MediaQuery.of(context).size.width - 40 - 10) / 2,
                    height: lastBoxHeight,
                    padding: EdgeInsets.only(left: 20), // 여백 추가
                    alignment: Alignment.centerLeft, // 텍스트를 세로 중심 왼쪽에 정렬
                    child: Text(
                      'F',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E4E4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
