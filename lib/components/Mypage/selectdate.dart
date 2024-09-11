import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarFormat _calendarFormat;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;

  final DateTime _firstDay = DateTime.utc(2024, 1, 1); // 시작 날짜 설정
  final DateTime _lastDay = DateTime.utc(2026, 12, 31); // 종료 날짜 설정

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '여행 기간을 선택해주세요!',
          style: TextStyle(color: Colors.black), // 텍스트 색상을 검정색으로 설정
        ),
        backgroundColor: Colors.white, // 앱바 배경색을 흰색으로 설정
        elevation: 0, // 그림자 제거
        iconTheme: IconThemeData(color: Colors.black), // 아이콘 색상 변경
      ),
      body: Container(
        color: Colors.white, // 전체 배경색을 흰색으로 설정
        child: Column(
          children: [
            TableCalendar(
              firstDay: _firstDay,
              lastDay: _lastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              rangeStartDay: _selectedStartDay, // 범위 시작 날짜
              rangeEndDay: _selectedEndDay, // 범위 끝 날짜
              selectedDayPredicate: (day) {
                // 선택된 날짜와 동일한지 확인
                return isSameDay(_selectedStartDay, day) ||
                    isSameDay(_selectedEndDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (_rangeSelectionMode == RangeSelectionMode.toggledOff) {
                    // 새로운 범위 시작 선택
                    if (_selectedStartDay != null &&
                        isSameDay(_selectedStartDay, selectedDay)) {
                      // 이미 선택된 시작 날짜를 다시 클릭하면 해제
                      _selectedStartDay = null;
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;
                    } else {
                      // 새로운 시작 날짜 선택
                      _selectedStartDay = selectedDay;
                      _selectedEndDay = null;
                      _rangeSelectionMode = RangeSelectionMode.toggledOn;
                    }
                  } else {
                    // 범위 종료 선택
                    if (_selectedEndDay != null &&
                        isSameDay(_selectedEndDay, selectedDay)) {
                      // 이미 선택된 종료 날짜를 다시 클릭하면 해제
                      _selectedEndDay = null;
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;
                    } else {
                      // 새로운 종료 날짜 선택
                      _selectedEndDay = selectedDay;
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;
                    }
                  }
                  _focusedDay = focusedDay;
                });

                // 선택된 날짜들을 다이얼로그가 열린 곳으로 반환
                if (_selectedStartDay != null && _selectedEndDay != null) {
                  Navigator.pop(context, [_selectedStartDay, _selectedEndDay]);
                }
              },
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _selectedStartDay = start;
                  _selectedEndDay = end;
                  _focusedDay = focusedDay;
                });

                if (start != null && end != null) {
                  // 선택된 날짜들을 다이얼로그가 열린 곳으로 반환
                  Navigator.pop(context, [start, end]);
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ],
        ),
      ),
    );
  }
}
