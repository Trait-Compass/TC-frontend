import 'package:flutter/material.dart';
import '../hooks/calendarforP.dart'; 
import '../components/start/basicframe2.dart';
import '../hooks/top3course.dart';

class Pselection extends StatefulWidget {
  @override
  _PselectionState createState() => _PselectionState();
}

class _PselectionState extends State<Pselection> {
  List<DateTime> selectedDates = [];
  DateTime? startDate; // 시작 날짜
  DateTime? endDate;   // 끝 날짜

  void _onDatesSelected1(List<DateTime> dates) {
    setState(() {
      selectedDates = dates;
      if (dates.isNotEmpty) {
        startDate = dates.first;
        endDate = dates.last;
    
        _proceedWithSelectedDates();
      } else {
        startDate = null;
        endDate = null;
      }
    });
  }

  void _proceedWithSelectedDates() {
    print('Selected Dates: $selectedDates');
    print('Start Date: $startDate');
    print('End Date: $endDate');
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Color(0xFFE4E4E4), thickness: 1, height: 1),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Image.asset('assets/animation.png', height: 50),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '자기만의 여행코스를 만들어보세요! :)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'P형 코스 만들기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      'STEP 01 | 여행 기간 선택',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: screenHeight * 0.5,
                      padding: EdgeInsets.all(screenHeight * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomCalendarSelection(
                        onDatesSelected: _onDatesSelected1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Top3Courses(),
          ],
        ),
      ),
    );
  }
}
