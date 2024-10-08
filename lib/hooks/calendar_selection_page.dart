// calendar_selection_page.dart
import 'package:flutter/material.dart';
import '../components/basic_frame_page.dart';
import '../hooks/calendar.dart'; 
import '../pages/BestCourseTop3.dart';
import '../pages/GyeongNamRecommend.dart';

class CalendarSelectionPage extends StatefulWidget {
  final String mbti;

  CalendarSelectionPage({required this.mbti});

  @override
  _CalendarSelectionPageState createState() => _CalendarSelectionPageState();
}

class _CalendarSelectionPageState extends State<CalendarSelectionPage> {
  List<DateTime> selectedDates = [];

  void _onDatesSelected(List<DateTime> dates) {
    setState(() {
      selectedDates = dates;
      print('Selected dates: $selectedDates');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    print('Building CalendarSelectionPage with selectedDates: $selectedDates');

    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(color: Colors.grey[200], thickness: 1, height: 1),
            SizedBox(height: screenHeight * 0.02),
            _buildIntro(screenHeight),
            _buildTitle(screenHeight),
            _buildCalendarSection(screenHeight),
            SizedBox(height: screenHeight * 0.02),
            BestCourseTop3(),
            SizedBox(height: screenHeight * 0.02),
            GyeongNamRecommend(),
          ],
        ),
      ),
    );
  }

  Widget _buildIntro(double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 20),
          Image.asset(
            'assets/animation.png',
            height: 50,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${widget.mbti}님!\n오늘은 경상남도 어디로 떠나볼까요?',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildTitle(double screenHeight) {
    return Text(
      'MBTI 맞춤형 간단 추천 코스',
      style: TextStyle(
        fontSize: screenHeight * 0.03,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCalendarSection(double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(20),
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
            SizedBox(height: 10),
            Container(
              height: screenHeight * 0.5,
              padding: EdgeInsets.all(screenHeight * 0.02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomCalendar(
                onDatesSelected: _onDatesSelected,
                mbti: widget.mbti, // mbti 전달
              ),
            ),
          ],
        ),
      ),
    );
  }
}