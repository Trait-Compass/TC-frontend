import 'package:flutter/material.dart';
import 'calendar_selection_page.dart'; // 달력 선택 페이지 파일을 import

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          color: Colors.white,
          child: AppBar(
            centerTitle: true,
            title: Image.asset('assets/mbtilogo.jpg', height: 40), // MBTI 로고 경로
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
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Image.asset('assets/animation.png', height: 50), // 사람 아이콘 경로
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      selectedMBTI.length == 4
                          ? '${selectedMBTI.join()} OOO님!\n오늘은 경상남도 어디로 떠나볼까요?'
                          : '경상남도 추천지를 원하시면 MBTI를 선택해주세요 !!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'MBTI 맞춤형 간단 추천 코스',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            StepOneWidget(
              selectedMBTI: selectedMBTI,
              toggleSelection: toggleSelection,
              onNextPressed: navigateToCalendarPage,
            ),
            SizedBox(height: 20), // 추가 여백
            RecommendedCourses(),
            SizedBox(height: 20), // 추가 여백
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '경상남도 행사 & 축제',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SortOptions(),
                ],
              ),
            ),
            EventsAndFestivals(),
            SizedBox(height: 20), // 추가 여백
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // 하단바 배경색을 흰색으로 설정
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/home.jpg', height: 30), // 홈 아이콘 경로
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/location1.png', height: 30), // 여행 일정 아이콘 경로
            label: '여행 일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/myprofile.png', height: 30), // 내 정보 아이콘 경로
            label: '내 정보',
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'STEP 01 | MBTI 입력',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedMBTI.length == 4 ? onNextPressed : null,
              child: Text('다음'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
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
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(3),
      child: ElevatedButton(
        onPressed: () => toggleSelection(mbti),
        child: Text(mbti, style: TextStyle(fontSize: 18)),
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

class RecommendedCourses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '인기 추천코스\nBEST 3',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              RecommendedCourseCard(
                imagePath: 'assets/course1.png',
                title: '해금강해안도로',
                location: '거제',
                mbti: 'ENTP',
              ),
              RecommendedCourseCard(
                imagePath: 'assets/course2.png',
                title: '시간여행마을',
                location: '창녕',
                mbti: 'ISTJ',
              ),
              RecommendedCourseCard(
                imagePath: 'assets/course3.png',
                title: '우포늪',
                location: '창녕',
                mbti: 'ESTJ',
              ),
              Container(
                width: 100,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/your_image.png', // 여기에 이미지 경로를 넣으세요
                        height: 30, // 적절한 높이로 조절하세요
                      ),
                      SizedBox(width: 10), // 이미지와 텍스트 사이의 간격을 조절하세요
                      Text(
                        '다른 코스가 보고 싶다면?',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecommendedCourseCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String mbti;

  const RecommendedCourseCard({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.mbti,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(left: 20, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              '$mbti\n$title\n$location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventsAndFestivals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              EventFestivalCard(
                imagePath: 'assets/event1.png',
                title: '거제 바다로 세계로',
                description: '거제의 대표적인 여름 축제',
              ),
              EventFestivalCard(
                imagePath: 'assets/event2.png',
                title: '창녕 남지 유채꽃 축제',
                description: '봄에 즐기는 아름다운 유채꽃',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EventFestivalCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const EventFestivalCard({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(left: 20, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              '$title\n$description',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SortOptions extends StatefulWidget {
  @override
  _SortOptionsState createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  String selectedOption = 'latest';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SortOption(
          text: '최신순',
          isSelected: selectedOption == 'latest',
          onTap: () {
            setState(() {
              selectedOption = 'latest';
            });
          },
        ),
        SizedBox(width: 10),
        SortOption(
          text: '인기순',
          isSelected: selectedOption == 'popular',
          onTap: () {
            setState(() {
              selectedOption = 'popular';
            });
          },
        ),
      ],
    );
  }
}

class SortOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SortOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
