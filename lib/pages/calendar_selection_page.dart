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

  Widget buildDateWidget(DateTime date) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    bool selected = isSelected(date);
    bool between = isBetweenSelectedDates(date);

    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Container(
        margin: EdgeInsets.all(screenWidth * 0.005),
        width: screenWidth * 0.05, //날짜크기 및 원크기 한번에 조절....
        height: screenWidth * 0.1, //날짜간 세로 간격조절
        decoration: BoxDecoration(
          color: selected ? Colors.grey : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            if (between)
              Positioned.fill(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
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

  Widget buildCalendarMonth(int year, int month) {
    DateTime firstDate = DateTime(year, month, 1);
    DateTime lastDate =
        DateTime(year, month + 1, 0); // 다음 달의 0번째 날짜는 해당 달의 마지막 날짜
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
          margin: EdgeInsets.all(2),
          width: 32,
          height: 32,
          child: Center(
            child: Text(day, style: TextStyle(color: textColor)),
          ),
        );
      }).toList(),
    ));

    while (currentDate.isBefore(lastDate.add(Duration(days: 1)))) {
      List<Widget> days = [];
      for (int i = 0; i < 7; i++) {
        if ((i < currentDate.weekday % 7 && currentDate.day == 1) ||
            currentDate.month != month) {
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

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }

  Widget buildCalendar() {
    List<Widget> months = [];
    int year = 2024; // 2024년 한 해만 표시
    for (int month = 1; month <= 12; month++) {
      months.add(buildCalendarMonth(year, month));
    }
    return Column(children: months);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
              color: Color(0xFFE4E4E4), // 실선 색상 설정
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
                        child: buildCalendar(),
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
