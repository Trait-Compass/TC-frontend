import 'package:flutter/material.dart';
import '../components/basic_frame_page.dart';
import '../hooks/top3course.dart';
import '../hooks/calendar_selection_page.dart';

class Pselection extends StatefulWidget {
  @override
  _PselectionState createState() => _PselectionState();
}

class _PselectionState extends State<Pselection> {
  @override
  Widget build(BuildContext context) {
    return BasicFramePage(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Color(0xFFE4E4E4),
              thickness: 1,
              height: 1,
            ),
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
                      '자기만의 여행코스를 만들어보세요!:)',
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
            // CalendarSelectionPage 위젯 추가
            CalendarSelectionPage(
              mbti: 'P',
            ),
            SizedBox(height: 10),
            // Top3Courses 위젯 추가
            Top3Courses(),
          ],
        ),
      ),
    );
  }
}
