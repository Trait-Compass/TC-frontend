import 'package:flutter/material.dart';
import 'course_generation_page.dart'; // 새로운 페이지를 import

class CalendarSelectionPage extends StatefulWidget {
  final String mbti;

  CalendarSelectionPage({required this.mbti});

  @override
  _CalendarSelectionPageState createState() => _CalendarSelectionPageState();
}

class _CalendarSelectionPageState extends State<CalendarSelectionPage> {
  DateTime selectedDate = DateTime(2024, 7, 1);
  List<DateTime> selectedDates = [];

  void onDateSelected(DateTime date) {
    setState(() {
      if (selectedDates.contains(date)) {
        selectedDates.remove(date);
      } else {
        selectedDates.add(date);
      }
      selectedDates.sort();
    });
  }

  bool isSelected(DateTime date) {
    return selectedDates.contains(date);
  }

  bool isBetweenSelectedDates(DateTime date) {
    if (selectedDates.length < 2) return false;
    return date.isAfter(selectedDates.first) &&
        date.isBefore(selectedDates.last);
  }

  Widget buildDateWidget(DateTime date) {
    bool selected = isSelected(date);
    bool between = isBetweenSelectedDates(date);

    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Container(
        margin: EdgeInsets.all(2),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            if (between)
              Positioned.fill(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  color: Colors.grey,
                ),
              ),
            Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalendar() {
    DateTime firstDate = DateTime(2024, 7, 1);
    DateTime lastDate = DateTime(2030, 12, 31);
    DateTime currentDate = DateTime(selectedDate.year, selectedDate.month, 1);
    List<Widget> rows = [];

    List<String> daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: daysOfWeek.map((day) {
        Color textColor = Colors.black;
        if (day == '일') textColor = Colors.red;
        if (day == '토') textColor = Colors.blue;
        return Container(
          margin: EdgeInsets.all(2),
          width: 32,
          height: 32,
          child: Center(
            child: Text(day, style: TextStyle(color: textColor)),
          ),
        );
      }).toList(),
    ));

    while (currentDate.month == selectedDate.month) {
      List<Widget> days = [];
      for (int i = 0; i < 7; i++) {
        if ((i < currentDate.weekday % 7 && currentDate.day == 1) ||
            currentDate.month != selectedDate.month) {
          days.add(Container(width: 32, height: 32));
        } else {
          days.add(buildDateWidget(currentDate));
          currentDate = currentDate.add(Duration(days: 1));
        }
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: days,
      ));
    }
    return Column(children: rows);
  }

  List<DropdownMenuItem<int>> getYearItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int year = 2024; year <= 2030; year++) {
      items.add(DropdownMenuItem(
        child: Text(year.toString()),
        value: year,
      ));
    }
    return items;
  }

  List<DropdownMenuItem<int>> getMonthItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int month = 1; month <= 12; month++) {
      items.add(DropdownMenuItem(
        child: Text(month.toString()),
        value: month,
      ));
    }
    return items;
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
                      '${widget.mbti} OOO님!\n오늘은 경상남도 어디로 떠나볼까요?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                a),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'MBTI 맞춤형 간단 추천 코스',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
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
                      'STEP 02 | 날짜 입력',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<int>(
                                value: selectedDate.year,
                                items: getYearItems(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDate = DateTime(value!,
                                        selectedDate.month, selectedDate.day);
                                  });
                                },
                              ),
                              SizedBox(width: 20),
                              DropdownButton<int>(
                                value: selectedDate.month,
                                items: getMonthItems(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDate = DateTime(selectedDate.year,
                                        value!, selectedDate.day);
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          buildCalendar(),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CourseGenerationPage(mbti: widget.mbti),
                          ),
                        );
                      },
                      child: Text('완료'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
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
            icon:
                Image.asset('assets/location1.png', height: 30), // 여행 일정 아이콘 경로
            label: '여행 일정',
          ),
          BottomNavigationBarItem(
            icon:
                Image.asset('assets/myprofile.png', height: 30), // 내 정보 아이콘 경로
            label: '내 정보',
          ),
        ],
      ),
    );
  }
}
