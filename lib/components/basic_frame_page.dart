import 'package:flutter/material.dart';
import 'mbti_selection_page.dart'; // MBTI 선택 페이지 파일을 import
import '../pages/BestCourseTop3.dart'; // 인기 추천코스 파일을 import
import '../pages/GyeongNamRecommend.dart'; // 경상남도 행사 & 축제 파일을 import
import '../hooks/loginpage.dart'; // LoginScreen 파일을 import

class BasicFramePage extends StatefulWidget {
  @override
  _BasicFramePageState createState() => _BasicFramePageState();
}

class _BasicFramePageState extends State<BasicFramePage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: Container(
          color: Colors.white,
          child: AppBar(
            centerTitle: true,
            title: Image.asset('assets/mbtilogo.jpg',
                height: screenHeight * 0.05), // MBTI 로고 경로
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: Image.asset('assets/alarm.jpg'), // 알림 아이콘 경로
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MBTISelectionPage(),
            SizedBox(height: screenHeight * 0.04), // 위젯 간 간격
            BestCourseTop3(),
            SizedBox(height: screenHeight * 0.04), // 위젯 간 간격
            GyeongNamRecommend(),
            SizedBox(height: screenHeight * 0.04) // 밑 공간 여유주기
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // 하단바 배경색을 흰색으로 설정
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.jpg',
                height: screenHeight * 0.04), // 홈 아이콘 경로
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/location1.png',
                height: screenHeight * 0.04), // 여행 일정 아이콘 경로
            label: '여행 일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/myprofile.png',
                height: screenHeight * 0.04), // 내 정보 아이콘 경로
            label: '내 정보',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 2) {
            // 내 정보 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          } else {
            // 추후 다른 페이지 이동 로직을 여기에 추가
          }
        },
      ),
    );
  }
}
