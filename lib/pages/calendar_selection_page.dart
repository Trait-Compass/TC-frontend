import 'package:flutter/material.dart';
import 'course_generation_page.dart'; // 새로운 페이지를 import

class CalendarSelectionPage extends StatefulWidget {
  final String mbti;

  CalendarSelectionPage({required this.mbti});

  @override
  _CalendarSelectionPageState createState() => _CalendarSelectionPageState();
}

class _CalendarSelectionPageState extends State<CalendarSelectionPage> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = [];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 박스의 가로 길이는 화면 너비의 1/10로 설정
    final double boxWidth = screenWidth * 0.1;

    // 박스의 세로 길이는 화면 높이의 10%로 설정
    final double boxHeight = screenHeight * 0.06;

    void onDateSelected(DateTime date) {
      setState(() {
        if (selectedDates.contains(date)) {
          selectedDates.remove(date);
        } else {
          if (selectedDates.length < 2) {
            selectedDates.add(date);
          }
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

    Widget buildDateWidget(DateTime date, double boxWidth) {
      bool selected = isSelected(date);
      bool between = isBetweenSelectedDates(date);

      const double textSize = 16.0; // 상수로 텍스트 크기를 설정

      return GestureDetector(
        onTap: () => onDateSelected(date),
        child: Container(
          width: boxWidth,
          height: boxHeight,
          decoration: BoxDecoration(
            color: selected ? Colors.grey : Colors.white,
            border: Border.all(color: Colors.white), // 날짜박스 테두리 색상
          ),
          child: Center(
            child: Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: textSize, // 상수로 설정된 텍스트 크기
                color: selected ? Colors.white : Colors.black, // 날짜 텍스트 색상
              ),
            ),
          ),
        ),
      );
    }

    Widget buildCalendarMonth(int year, int month, double boxWidth) {
      DateTime firstDate = DateTime(year, month, 1);
      DateTime lastDate = DateTime(year, month + 1, 0);
      DateTime currentDate = firstDate;

      List<Widget> rows = [];

      rows.add(Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$year년",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              "$month월",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ));

      List<String> daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: daysOfWeek.map((day) {
          Color textColor = Colors.black;
          if (day == '일') textColor = Colors.red;
          if (day == '토') textColor = Colors.blue;
          return Container(
            width: boxWidth,
            height: boxHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
            ),
            child: Center(
              child: Text(
                day,
                style:
                    TextStyle(color: textColor, fontSize: 16), // 상수로 텍스트 크기 설정
              ),
            ),
          );
        }).toList(),
      ));

      while (currentDate.isBefore(lastDate.add(Duration(days: 1)))) {
        List<Widget> days = [];
        for (int i = 0; i < 7; i++) {
          if ((i < currentDate.weekday % 7 && currentDate.day == 1) ||
              currentDate.month != month) {
            days.add(Container(
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
              ),
            ));
          } else {
            days.add(buildDateWidget(currentDate, boxWidth));
            currentDate = currentDate.add(Duration(days: 1));
          }
        }
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: days,
        ));

        // 각 날짜 행 사이에 가로로 긴 박스를 추가
        rows.add(Container(
          width: double.infinity,
          height: boxHeight / 2,
          color: Colors.white,
        ));
      }

      return Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: rows);
    }

    Widget buildCalendar(double boxWidth) {
      List<Widget> months = [];
      int year = 2024;
      for (int month = 1; month <= 12; month++) {
        months.add(buildCalendarMonth(year, month, boxWidth));
      }
      return Column(children: months);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
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
                icon: Image.asset('assets/alarm.jpg',
                    height: screenHeight * 0.04), // 알림 아이콘 경로
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
              color: Color(0xFFE4E4E4),
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.05),
                Image.asset('assets/animation.png',
                    height: screenHeight * 0.07), // 사람 아이콘 경로
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${widget.mbti} OOO님!\n오늘은 경상남도 어디로 떠나볼까요?',
                      style: TextStyle(fontSize: screenHeight * 0.018),
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
            Padding(
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
                      'STEP 02 | 날짜 입력',
                      style: TextStyle(fontSize: screenHeight * 0.02),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      height: screenHeight * 0.5,
                      padding: EdgeInsets.all(screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        child: buildCalendar(boxWidth),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ElevatedButton(
                      onPressed: selectedDates.length == 2
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CourseGenerationPage(mbti: widget.mbti),
                                ),
                              );
                            }
                          : null,
                      child: Text('완료'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedDates.length == 2
                            ? Colors.grey[800]
                            : Colors.grey[400],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
