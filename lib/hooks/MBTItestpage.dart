import 'package:flutter/material.dart';
import '../components/basicframe.dart';
import '../components/mbtitest/0question.dart';
import '../components/mbtitest/1question.dart';
import '../components/mbtitest/2question.dart';

// StatefulWidget 구현
class MBTItestselection extends StatefulWidget {
  @override
  _MBTItestselectionState createState() => _MBTItestselectionState();
}

// State 클래스 구현
class _MBTItestselectionState extends State<MBTItestselection> {
  bool isStarted = false;
  String selectedOption = '';

  void _handleOptionSelected(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  void _startTest() {
    setState(() {
      isStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BasicFrame1Page(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: Color(0xFFE4E4E4),
                thickness: 1,
                height: 1,
              ),
              SizedBox(height: 20),
              Text(
                '나의 여행 MBTI는?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              StartTestSection(
                onStartPressed: _startTest,
                isStarted: isStarted,
                onOptionSelected: _handleOptionSelected,
                selectedOption: selectedOption,
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth - 40,
                height: 400,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('../assets/mascoat.png', height: 100),
                    SizedBox(height: 20),
                    Text(
                      '안녕하세요 창녕군 마스코트 따오기예요!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'MBTI를 먼저 입력해주세요',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '입력 후, 다른 MBTI의 성향도 볼 수 있어요!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
