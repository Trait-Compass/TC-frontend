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
  late Widget _currentBody; 

  @override
  void initState() {
    super.initState();
    _currentBody = widget.body;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 2) {
        _currentBody = Mypage();
      } else if (index == 0) {
        _currentBody = MBTISelectionPage();
      } else {
        _currentBody = MyNewPage();
      }
    });
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
      body: _currentBody,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/house.png',
              height: screenHeight * 0.04,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/location1.png',
              height: screenHeight * 0.04,
            ),
            label: '여행 일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/myprofile.png',
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