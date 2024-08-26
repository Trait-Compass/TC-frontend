import 'package:flutter/material.dart';
import '../components/basic_frame_page.dart'; // BasicFramePage 임포트

// StatefulWidget 구현
class MBTItestselection extends StatefulWidget {
  @override
  _MBTItestselectionState createState() => _MBTItestselectionState();
}

// State 클래스 구현
class _MBTItestselectionState extends State<MBTItestselection> {
  @override
  Widget build(BuildContext context) {
    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // 상단 섹션: MBTI 테스트 버튼
            Center(
              child: Column(
                children: [
                  Text(
                    '나의 여행 MBTI는?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // 임시로 페이지 이동하지 않도록 설정
                      // 예시: Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // 테두리 색상 설정
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Image.asset('assets/airplane_icon.png',
                              height: 100), // 비행기 아이콘 이미지 추가
                          SizedBox(height: 10),
                          Text(
                            'MBTI 테스트',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // 여기도 임시로 페이지 이동하지 않도록 설정
                    },
                    child: Text('시작하기'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // 중간 섹션: 마스코트와 설명 텍스트
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // 마스코트 이미지
                  Image.asset('assets/mascot.png', height: 100),
                  SizedBox(height: 20),
                  Text(
                    '안녕하세요 창녕군 마스코트 따오기예요!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'MBTI를 먼저 입력해주세요',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '입력 후, 다른 MBTI의 성향도 볼 수 있어요!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
