import 'package:flutter/material.dart';
import '../components/Mypage/myprofilefirstpage.dart';
import '../components/mbti_selection_page.dart';
import '../pages/travelplan.dart';

class BasicFramePage extends StatefulWidget {
  final Widget body;

  BasicFramePage({required this.body});

  @override
  _BasicFramePageState createState() => _BasicFramePageState();
}

class _BasicFramePageState extends State<BasicFramePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 2) {
      // 내 정보 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Mypage()),
      );
    } else if (index == 0) {
      // 홈 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MBTISelectionPage()),
      );
    } else {
      // 여행 일정 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyNewPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/mbtilogo.jpg', height: screenHeight * 0.05),
        backgroundColor: Colors.white, 
        elevation: 0, 
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white, 
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/alarm.jpg'),
            onPressed: () {},
          ),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 0 ? 'assets/house.png' : 'assets/house.png',
              height: screenHeight * 0.04,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 1
                  ? 'assets/location2.png'
                  : 'assets/location1.png',
              height: screenHeight * 0.04,
            ),
            label: '여행 일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              _currentIndex == 2
                  ? 'assets/myprofile1.png'
                  : 'assets/myprofile.png',
              height: screenHeight * 0.04,
            ),
            label: '내 정보',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
