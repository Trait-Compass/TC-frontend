import 'package:flutter/material.dart';
import '../basic_frame_page.dart'; // 실제 경로는 프로젝트 구조에 따라 다를 수 있습니다.
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
    // final grayBoxHeight = screenHeight * 0.15; // 회색 박스의 높이
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '나의 프로필',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '내가 저장한 여행 코스',
                style: TextStyle(
                  fontSize: 15,
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
                  fontSize: 15,
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
                  fontSize: 15,
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DiaryforT()),
                        );
                      },
                      child: Container(
                        height: lastBoxHeight,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFE4E4E4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'T',
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
                                  child: Text(
                                    "# 만족도 그래프",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                  child: Text(
                                    "# 여행 상세분석",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DiaryforF()),
                        );
                      },
                      child: Container(
                        height: lastBoxHeight,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFE4E4E4),
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                                  child: Text(
                                    "# 감정 차트",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                  child: Text(
                                    "# 나의 감성 기록",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
