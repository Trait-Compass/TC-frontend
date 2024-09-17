import 'package:flutter/material.dart';

class CustomDateRangeSelector extends StatefulWidget {
  final Function(List<DateTime>) onDateRangeSelected;

  CustomDateRangeSelector({required this.onDateRangeSelected});

  @override
  _CustomDateRangeSelectorState createState() =>
      _CustomDateRangeSelectorState();
}

class _CustomDateRangeSelectorState extends State<CustomDateRangeSelector> {
  List<DateTime> chosenDates = [];

  void selectOrDeselectDate(DateTime date) {
    setState(() {
      if (chosenDates.contains(date)) {
        chosenDates.remove(date);
      } else {
        if (chosenDates.length == 2) {
          chosenDates.clear();
        }
        chosenDates.add(date);
        chosenDates.sort();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double cellWidth = screenWidth / 7.5;
    final double cellHeight = screenHeight * 0.06;

    bool isDateChosen(DateTime date) => chosenDates.contains(date);

    bool isDateWithinRange(DateTime date) {
      if (chosenDates.length < 2) return false;
      return date.isAfter(chosenDates.first) && date.isBefore(chosenDates.last);
    }

    BoxDecoration generateBoxDecoration(DateTime date) {
      if (isDateChosen(date)) {
        if (chosenDates.first == date) {
          return BoxDecoration(
            color: Color(0xFF6699FF),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20.0),
            ),
          );
        } else if (chosenDates.last == date) {
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
      } else if (isDateWithinRange(date)) {
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

    TextStyle generateTextStyle(DateTime date) {
      if (isDateChosen(date)) {
        return TextStyle(
          color: Color(0xFFFAFAFA),
          fontSize: 16.0,
        );
      } else if (isDateWithinRange(date)) {
        return TextStyle();
      } else {
        return TextStyle(
          color: Colors.black,
        );
      }
    }

    Widget createDateTile(DateTime date, double cellWidth) {
      return GestureDetector(
        onTap: () => selectOrDeselectDate(date),
        child: Container(
          width: cellWidth,
          height: cellHeight,
          decoration: generateBoxDecoration(date),
          child: Center(
            child: Text(
              date.day.toString(),
              style: generateTextStyle(date),
            ),
          ),
        ),
      );
    }

    Widget createMonthlyCalendar(int year, int month, double cellWidth) {
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
              width: cellWidth,
              height: cellHeight,
              decoration: BoxDecoration(color: Colors.white),
            ));
          } else {
            days.add(createDateTile(currentDate, cellWidth));
            currentDate = currentDate.add(Duration(days: 1));
          }
        }
        rows.add(Table(children: [TableRow(children: days)]));
      }

      rows.add(Container(
        width: double.infinity,
        height: cellHeight / 2,
        color: Colors.white,
      ));

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      );
    }

    Widget createFullYearCalendar(double cellWidth) {
      List<Widget> months = [];
      int year = 2024;
      for (int month = 1; month <= 12; month++) {
        months.add(createMonthlyCalendar(year, month, cellWidth));
      }
      return Column(children: months);
    }

    return Center(
      child: Container(
        width: screenWidth * 0.8, // 원하는 너비로 설정 (화면 너비의 90%)
        height: screenHeight * 0.8, // 원하는 높이로 설정 (화면 높이의 80%)
        color: Colors.white, // 전체 배경색 흰색으로 설정
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: createFullYearCalendar(cellWidth),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: chosenDates.length == 2
                    ? () {
                        widget.onDateRangeSelected(
                            chosenDates); // 콜백 함수로 선택한 날짜 전달
                        Navigator.pop(context); // 다이얼로그 닫기
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: chosenDates.length == 2
                      ? Colors.grey[800]
                      : Colors.grey[400], // 조건에 따른 색상 설정
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: Text('완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
