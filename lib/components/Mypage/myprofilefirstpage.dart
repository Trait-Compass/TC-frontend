import 'package:flutter/material.dart';
import '../basic_frame_page.dart'; // 가정한 경로, 실제 import 경로에 맞게 수정 필요
import '../Mypage/diaryforT.dart';
import '../Mypage/diaryforF.dart';

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
    final smallBoxHeight = lastBoxHeight / 5; // 작은 박스의 세로 길이
    final smallBoxWidth = 100.0; // 작은 박스의 가로 길이

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
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  '나의 프로필',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                width: double.infinity,
                height: grayBoxHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    )),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '내가 저장한 여행 코스',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: whiteBoxHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    )),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '여행 일기장',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: whiteBoxHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    )),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '일기 작성하기',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: lastBoxHeight,
                      alignment: Alignment
                          .center, // Align items to the center horizontally
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the row content horizontally
                        children: [
                          Text(
                            'T',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              width: 30), // Space between "T" and the columns
                          Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Align column contents vertically
                            children: [
                              Container(
                                width: smallBoxWidth,
                                height: smallBoxHeight,
                                alignment: Alignment.center,
                                child: Text("# 만족도 그래프",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(height: 5), // Space between boxes
                              Container(
                                width: smallBoxWidth,
                                height: smallBoxHeight,
                                alignment: Alignment.center,
                                child: Text("# 여행 상세분석",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE4E4E4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Space between the two main containers
                  Expanded(
                    child: Container(
                      height: lastBoxHeight,
                      alignment:
                          Alignment.center, // Same as the first container
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'F',
                            style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: smallBoxWidth,
                                height: smallBoxHeight,
                                alignment: Alignment.center,
                                child: Text("# 감정 차트",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: smallBoxWidth,
                                height: smallBoxHeight,
                                alignment: Alignment.center,
                                child: Text("# 나의 감성 기록",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE4E4E4),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
