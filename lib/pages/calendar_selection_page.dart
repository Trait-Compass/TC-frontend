import 'package:flutter/material.dart';
import 'course_generation_page.dart';
import 'BestCourseTop3.dart';
import 'GyeongNamRecommend.dart';

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

    final double boxWidth = screenWidth / 7.5;
    final double boxHeight = screenHeight * 0.06;

    void onDateSelected(DateTime date) {
      setState(() {
        if (selectedDates.length == 2) {
          selectedDates.clear();
        }
        selectedDates.add(date);
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

    BoxDecoration buildBoxDecoration(DateTime date) {
      if (isSelected(date)) {
        if (selectedDates.first == date) {
          return BoxDecoration(
            color: Color(0xFF6699FF),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20.0),
              right: Radius.zero,
            ),
          );
        } else if (selectedDates.last == date) {
          return BoxDecoration(
            color: Color(0xFF6699FF),
            borderRadius: BorderRadius.horizontal(
              left: Radius.zero,
              right: Radius.circular(20.0),
            ),
          );
        }
        return BoxDecoration(
          color: Color(0xFF6699FF),
          shape: BoxShape.circle,
        );
      } else if (isBetweenSelectedDates(date)) {
        return BoxDecoration(
          color: Color(0xFFBBDDFF),
          shape: BoxShape.rectangle,
        );
      } else {
        return BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        );
      }
    }

    TextStyle buildTextStyle(DateTime date) {
      if (isSelected(date)) {
        return TextStyle(
          color: Color(0xFFFAFAFA),
          fontSize: 16.0,
        );
      } else if (isBetweenSelectedDates(date)) {
        return TextStyle(); // 범위 내의 날짜 글자 스타일
      } else {
        return TextStyle(
          color: Colors.black,
        );
      }
    }

    Widget buildDateWidget(DateTime date, double boxWidth) {
      return GestureDetector(
        onTap: () => onDateSelected(date),
        child: Container(
          width: boxWidth,
          height: boxHeight,
          decoration: buildBoxDecoration(date),
          child: Center(
            child: Text(
              date.day.toString(),
              style: buildTextStyle(date),
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

      // 요일 표시 부분
      List<String> daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

      rows.add(
        Table(
          children: [
            TableRow(
              children: daysOfWeek.map((day) {
                Color textColor = Colors.black;
                if (day == '일') textColor = Colors.red;
                if (day == '토') textColor = Colors.blue;

                return Container(
                  alignment: Alignment.center, // 중앙 정렬
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Text(
                    day,
                    style:
                        TextStyle(color: textColor, fontSize: 14), // 폰트 크기 감소
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );

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
        rows.add(
          Table(
            children: [
              TableRow(
                children: days,
              ),
            ],
          ),
        );
      }
      rows.add(Container(
        width: double.infinity,
        height: boxHeight / 2,
        color: Colors.white,
      ));

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
              color: Colors.grey[200],
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: screenWidth * 0.05),
                Image.asset('assets/animation.png',
                    height: screenHeight * 0.07,
                    fit: BoxFit.contain), // 이미지 크기와 맞춤 설정
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
            SizedBox(height: screenHeight * 0.02),
            BestCourseTop3(), // BestcourseTop3.dart 위젯 추가
            SizedBox(height: screenHeight * 0.02),
            GyeongNamRecommend(), // GyeongNamRecommend.dart 위젯 추가
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
