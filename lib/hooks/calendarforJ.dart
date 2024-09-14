import 'package:flutter/material.dart';
import '../Pages/LocationAndPersonSelectionJ.dart'; // 임포트 경로 확인 필요

class AdvancedCalendarSelection extends StatefulWidget {
  final Function(List<DateTime>) onDatesSelected;

  AdvancedCalendarSelection({required this.onDatesSelected});

  @override
  _AdvancedCalendarSelectionState createState() =>
      _AdvancedCalendarSelectionState();
}

class _AdvancedCalendarSelectionState extends State<AdvancedCalendarSelection> {
  List<DateTime> selectedDates = [];

  void toggleDateSelection(DateTime date) {
    setState(() {
      if (selectedDates.contains(date)) {
        selectedDates.remove(date);
      } else {
        if (selectedDates.length == 2) {
          selectedDates.clear();
        }
        selectedDates.add(date);
        selectedDates.sort();
      }
      widget.onDatesSelected(selectedDates);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double boxWidth = screenWidth / 7.5;
    final double boxHeight = screenHeight * 0.06;

    bool isSelected(DateTime date) => selectedDates.contains(date);

    bool isBetweenSelectedDates(DateTime date) {
      if (selectedDates.length < 2) return false;
      return date.isAfter(selectedDates.first) &&
          date.isBefore(selectedDates.last);
    }

    BoxDecoration createBoxDecoration(DateTime date) {
      if (isSelected(date)) {
        if (selectedDates.first == date) {
          return BoxDecoration(
            color: Color(0xFF6699FF),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20.0),
            ),
          );
        } else if (selectedDates.last == date) {
          return BoxDecoration(
            color: Color(0xFF6699FF),
            borderRadius: BorderRadius.horizontal(
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

    TextStyle createTextStyle(DateTime date) {
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

    Widget buildDateTile(DateTime date, double boxWidth) {
      return GestureDetector(
        onTap: () => toggleDateSelection(date),
        child: Container(
          width: boxWidth,
          height: boxHeight,
          decoration: createBoxDecoration(date),
          child: Center(
            child: Text(
              date.day.toString(),
              style: createTextStyle(date),
            ),
          ),
        ),
      );
    }

    Widget buildMonthCalendar(int year, int month, double boxWidth) {
      DateTime firstDate = DateTime(year, month, 1);
      DateTime lastDate = DateTime(year, month + 1, 0);
      DateTime currentDate = firstDate;

      List<Widget> rows = [];

      rows.add(Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$year년", style: TextStyle(color: Colors.grey, fontSize: 16)),
            Text("$month월",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ));

      List<String> daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

      rows.add(Table(
        children: [
          TableRow(
            children: daysOfWeek.map((day) {
              Color textColor = day == '일'
                  ? Colors.red
                  : day == '토'
                      ? Colors.blue
                      : Colors.black;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white),
                child:
                    Text(day, style: TextStyle(color: textColor, fontSize: 14)),
              );
            }).toList(),
          ),
        ],
      ));

      while (currentDate.isBefore(lastDate.add(Duration(days: 1)))) {
        List<Widget> days = [];
        for (int i = 0; i < 7; i++) {
          if ((i < currentDate.weekday % 7 && currentDate.day == 1) ||
              currentDate.month != month) {
            days.add(Container(
              width: boxWidth,
              height: boxHeight,
              decoration: BoxDecoration(color: Colors.white),
            ));
          } else {
            days.add(buildDateTile(currentDate, boxWidth));
            currentDate = currentDate.add(Duration(days: 1));
          }
        }
        rows.add(Table(children: [TableRow(children: days)]));
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

    Widget buildFullCalendar(double boxWidth) {
      List<Widget> months = [];
      int year = 2024;
      for (int month = 1; month <= 12; month++) {
        months.add(buildMonthCalendar(year, month, boxWidth));
      }
      return Column(children: months);
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: buildFullCalendar(boxWidth),
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
                        builder: (context) => LocationAndPersonSelectionJ(),
                      ),
                    );
                  }
                : null,
            child: Text('다음'),
          ),
        ),
      ],
    );
  }
}
