import 'package:flutter/material.dart';
import '../hooks/LocationAndPersonSelection.dart';

class CustomCalendarSelection extends StatefulWidget {
  final Function(List<DateTime>) onDatesSelected;

  CustomCalendarSelection({required this.onDatesSelected});

  @override
  _CustomCalendarSelectionState createState() =>
      _CustomCalendarSelectionState();
}

class _CustomCalendarSelectionState extends State<CustomCalendarSelection> {
  List<DateTime> selectedDates = [];

  void hotswap(DateTime date) {
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

      int daysSelected = selectedDates.length > 1
          ? selectedDates.last.difference(selectedDates.first).inDays + 1
          : 0;

      if (daysSelected > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('4박 5일까지 선택 가능합니다!'),
          ),
        );

        selectedDates.remove(date);
      } else {
        widget.onDatesSelected(selectedDates);
      }
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

    BoxDecoration buildBoxDecoration(DateTime date) {
      if (isSelected(date)) {
        if (selectedDates.first == date) {
          return BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20.0),
            ),
          );
        } else if (selectedDates.last == date) {
          return BoxDecoration(
            color: Colors.grey[800],
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
          color: Colors.grey[200],
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
        return TextStyle();
      } else {
        return TextStyle(
          color: Colors.black,
        );
      }
    }

    Widget buildDateWidget(DateTime date, double boxWidth) {
      return GestureDetector(
        onTap: () => hotswap(date),
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
            days.add(buildDateWidget(currentDate, boxWidth));
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

    Widget buildCalendar(double boxWidth) {
      List<Widget> months = [];
      
      int year = DateTime.now().year;
      int startMonth = DateTime.now().month;

      for (int month = startMonth; month <= 12; month++) {
        months.add(buildCalendarMonth(year, month, boxWidth));
      }

      year += 1;
      for (int month = 1; month <= 12; month++) {
        months.add(buildCalendarMonth(year, month, boxWidth));
      }

      return Column(children: months);
    }

    int daysSelected = selectedDates.length > 1
        ? selectedDates.last.difference(selectedDates.first).inDays + 1
        : 0;

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
            onPressed: (selectedDates.length >= 1 && daysSelected <= 5)
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationAndPersonSelectionPage(
                          selectedDates: selectedDates,
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: (selectedDates.length >= 1 && daysSelected <= 5)
                  ? Colors.grey[800]
                  : Colors.grey[400],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
            child: Text('다음'),
          ),
        ),
      ],
    );
  }
}