import 'package:flutter/material.dart';
import 'calendar_selection_page.dart'; // 달력 선택 페이지 파일을 import
import 'loginpage.dart'; // 로그인 페이지 파일을 import
import 'BestCourseTop3.dart'; // 새로운 파일 import
import 'GyeongNamRecommend.dart'; // 새로운 파일 import

class MBTISelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontWeight: FontWeight.bold),
          displayLarge: TextStyle(fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontWeight: FontWeight.bold),
          labelLarge: TextStyle(fontWeight: FontWeight.bold),
          labelMedium: TextStyle(fontWeight: FontWeight.bold),
          labelSmall: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: MBTISelectionPage(),
    );
  }
}

class MBTISelectionPage extends StatefulWidget {
  @override
  _MBTISelectionPageState createState() => _MBTISelectionPageState();
}

class _MBTISelectionPageState extends State<MBTISelectionPage> {
  List<String> selectedMBTI = [];
  int _selectedIndex = 0;

  void toggleSelection(String mbti) {
    setState(() {
      if (selectedMBTI.contains(mbti)) {
        selectedMBTI.remove(mbti);
      } else if (selectedMBTI.length < 4) {
        selectedMBTI.add(mbti);
      }
    });
  }

  void navigateToCalendarPage() {
    if (selectedMBTI.length == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarSelectionPage(
            mbti: selectedMBTI.join(),
          ),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      // '내 정보' 탭이 클릭되었을 때
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: Color(0xFFE4E4E4), // 실선 색상 설정
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.05),
                Image.asset('assets/animation.png',
                    height: screenHeight * 0.07), // 사람 아이콘 경로
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015,
                        horizontal: screenWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      selectedMBTI.length == 4
                          ? '${selectedMBTI.join()} OOO님!\n오늘은 경상남도 어디로 떠나볼까요?'
                          : '경상남도 추천지를 원하시면 MBTI를 선택해주세요 !!',
                      style: TextStyle(fontSize: screenHeight * 0.02),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'MBTI 맞춤형 간단 추천 코스',
              style: TextStyle(
                  fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            StepOneWidget(
              selectedMBTI: selectedMBTI,
              toggleSelection: toggleSelection,
              onNextPressed: navigateToCalendarPage,
            ),
            SizedBox(height: screenHeight * 0.02), // 추가 여백
            BestCourseTop3(), // 인기 추천코스 BEST 3 위젯 사용
            SizedBox(height: screenHeight * 0.02), // 추가 여백
            GyeongNamRecommend(), // 경상남도 행사 & 축제 위젯 사용
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class StepOneWidget extends StatelessWidget {
  final List<String> selectedMBTI;
  final Function(String) toggleSelection;
  final VoidCallback onNextPressed;

  const StepOneWidget({
    required this.selectedMBTI,
    required this.toggleSelection,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.03),
      child: Container(
        padding: EdgeInsets.all(screenHeight * 0.03),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'STEP 01 | MBTI 입력',
              style: TextStyle(fontSize: screenHeight * 0.02),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: screenHeight * 0.01),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: screenHeight * 0.01,
              runSpacing: screenHeight * 0.01,
              children: [
                MBTIGroup(
                  verticalItems: ['E', 'I'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  verticalItems: ['S', 'N'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  verticalItems: ['T', 'F'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  verticalItems: ['J', 'P'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: selectedMBTI.length == 4 ? onNextPressed : null,
              child: Text('다음'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MBTIGroup extends StatelessWidget {
  final List<String> verticalItems;
  final List<String> selectedItems;
  final Function(String) toggleSelection;

  const MBTIGroup({
    required this.verticalItems,
    required this.selectedItems,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Column(
        children: verticalItems.map((mbti) {
          return MBTIButton(
            mbti: mbti,
            isSelected: selectedItems.contains(mbti),
            toggleSelection: toggleSelection,
          );
        }).toList(),
      ),
    );
  }
}

class MBTIButton extends StatelessWidget {
  final String mbti;
  final bool isSelected;
  final Function(String) toggleSelection;

  const MBTIButton({
    required this.mbti,
    required this.isSelected,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenHeight * 0.07,
      height: screenHeight * 0.07,
      margin: EdgeInsets.all(screenHeight * 0.004),
      child: ElevatedButton(
        onPressed: () => toggleSelection(mbti),
        child: Text(mbti, style: TextStyle(fontSize: screenHeight * 0.025)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey[300] : Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey),
          ),
          elevation: 1,
        ),
      ),
    );
  }
}
