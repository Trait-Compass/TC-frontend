import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'recommended_courses_page.dart';

class MBTISelectionPage extends StatefulWidget {
  @override
  _MBTISelectionPageState createState() => _MBTISelectionPageState();
}

class _MBTISelectionPageState extends State<MBTISelectionPage> {
  List<String> selectedMBTI = [];

  void toggleSelection(String mbti) {
    setState(() {
      if (selectedMBTI.contains(mbti)) {
        selectedMBTI.remove(mbti);
      } else if (selectedMBTI.length < 4) {
        selectedMBTI.add(mbti);
      }
    });
  }

  Future<void> navigateToRecommendedCourses() async {
    if (selectedMBTI.length == 4) {
      try {
        List<dynamic> courses =
            await fetchRecommendedCourses(selectedMBTI.join());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecommendedCoursesPage(courses: courses),
          ),
        );
      } catch (e) {
        print('Error: $e');
        // 에러 처리
      }
    }
  }

  Future<List<dynamic>> fetchRecommendedCourses(String mbti) async {
    final response = await http.get(
      Uri.parse('/course/simple'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recommended courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('assets/mbtilogo.jpg', height: 40), // MBTI 로고 경로
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset('assets/alarm.jpg'), // 알림 아이콘 경로
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'MBTI 맞춤형 간단 추천 코스',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            StepOneWidget(
              selectedMBTI: selectedMBTI,
              toggleSelection: toggleSelection,
              onNextPressed: navigateToRecommendedCourses,
            ),
          ],
        ),
      ),
    );
  }
}

class StepOneWidget extends StatelessWidget {
  final List<String> selectedMBTI;
  final Function(String) toggleSelection;
  final VoidCallback onNextPressed;

  const StepOneWidget({
    required this.selectedMBTI,
    required this.toggleSelection,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
              'STEP 01 | MBTI 입력',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                MBTIGroup(
                  verticalItems: ['E', 'I'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  verticalItems: ['S', 'N'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  verticalItems: ['T', 'F'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  verticalItems: ['J', 'P'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedMBTI.length == 4 ? onNextPressed : null,
              child: Text('다음'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MBTIGroup extends StatelessWidget {
  final List<String> verticalItems;
  final List<String> selectedItems;
  final Function(String) toggleSelection;

  const MBTIGroup({
    required this.verticalItems,
    required this.selectedItems,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        children: verticalItems.map((mbti) {
          return MBTIButton(
            mbti: mbti,
            isSelected: selectedItems.contains(mbti),
            toggleSelection: toggleSelection,
          );
        }).toList(),
      ),
    );
  }
}

class MBTIButton extends StatelessWidget {
  final String mbti;
  final bool isSelected;
  final Function(String) toggleSelection;

  const MBTIButton({
    required this.mbti,
    required this.isSelected,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.all(3),
      child: ElevatedButton(
        onPressed: () => toggleSelection(mbti),
        child: Text(mbti, style: TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey[300] : Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey),
          ),
          elevation: 1,
        ),
      ),
    );
  }
}
