import 'package:flutter/material.dart';

class MyCalendar extends StatefulWidget {
  final Function(List<DateTime>) onDatesSelected;

  MyCalendar({required this.onDatesSelected});

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
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
        widget.onDatesSelected(selectedDates);
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

    return Container(
      color: Colors.white, // 전체 배경색을 흰색으로 설정
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: buildCalendar(boxWidth),
            ),
          ),
          // 완료 버튼 추가
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: selectedDates.length == 2
                  ? () {
                      widget.onDatesSelected(selectedDates);
                      Navigator.pop(context); // 다이얼로그 닫기
                    }
                  : null, // 선택된 날짜가 2개가 아닐 때는 비활성화
              child: Text('완료'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedDates.length == 2 ? Colors.blue : Colors.grey,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
