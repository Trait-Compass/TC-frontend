import 'package:flutter/material.dart';
import 'package:untitled/pages/course_generation_page.dart';

class CustomCalendar extends StatefulWidget {
  final Function(List<DateTime>) onDatesSelected;

  CustomCalendar({required this.onDatesSelected});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  List<DateTime> selectedDates = [];

  void onDateSelected(DateTime date) {
    setState(() {
      if (selectedDates.contains(date)) {
        // 이미 선택된 날짜를 다시 선택하면 제거
        selectedDates.remove(date);
      } else {
        // 날짜 추가 (최대 2개만 유지)
        if (selectedDates.length == 2) {
          selectedDates.clear();
        }
        selectedDates.add(date);
        selectedDates.sort();
      }
      widget.onDatesSelected(selectedDates); // 선택된 날짜 업데이트 콜백 호출
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double boxWidth = screenWidth / 7.5;
    final double boxHeight = screenHeight * 0.06;

    // 날짜가 선택되었는지 확인
    bool isSelected(DateTime date) {
      return selectedDates.contains(date);
    }

    // 선택된 날짜 사이에 있는지 확인
    bool isBetweenSelectedDates(DateTime date) {
      if (selectedDates.length < 2) return false;
      return date.isAfter(selectedDates.first) && date.isBefore(selectedDates.last);
    }

    // 박스의 데코레이션 스타일 설정
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

    // 텍스트 스타일 설정
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

    // 날짜 위젯 생성
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

    // 월별 캘린더 생성
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

      rows.add(
        Table(
          children: [
            TableRow(
              children: daysOfWeek.map((day) {
                Color textColor = Colors.black;
                if (day == '일') textColor = Colors.red;
                if (day == '토') textColor = Colors.blue;

                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Text(
                    day,
                    style: TextStyle(color: textColor, fontSize: 14),
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
          if ((i < currentDate.weekday % 7 && currentDate.day == 1) || currentDate.month != month) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      );
    }

    // 전체 캘린더 생성
    Widget buildCalendar(double boxWidth) {
      List<Widget> months = [];
      int year = 2024;
      for (int month = 1; month <= 12; month++) {
        months.add(buildCalendarMonth(year, month, boxWidth));
      }
      return Column(children: months);
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: buildCalendar(boxWidth),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: selectedDates.isNotEmpty
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CourseGenerationPage(mbti: 'mbti'),
                      ),
                    );
                  }
                : null, // 선택된 날짜가 없으면 비활성화
            child: Text('완료'),
          ),
        ),
      ],
    );
  }
}
