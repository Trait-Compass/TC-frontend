import 'package:flutter/material.dart';
import '../hooks/loginscreen.dart';
import '../components/mbti_selection_page.dart';
import '../hooks/travelplan.dart';

class BasicFramePage extends StatelessWidget {
  final Widget body; // body 매개변수를 추가합니다.

  BasicFramePage({required this.body});

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
      body: body, // 전달된 body 위젯을 여기에 배치합니다.
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // 하단바 배경색을 흰색으로 설정
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.jpg', height: screenHeight * 0.04),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/location1.png',
                height: screenHeight * 0.04),
            label: '여행 일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/myprofile.png',
                height: screenHeight * 0.04),
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
            // 홈 또는 여행 일정 페이지로 이동
            index == 0
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MBTISelectionPage()),
                  )
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyNewPage()),
                  );
          }
        },
      ),
    );
  }
}
