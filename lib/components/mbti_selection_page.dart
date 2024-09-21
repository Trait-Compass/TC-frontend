import 'package:flutter/material.dart';
import '../hooks/calendar_selection_page.dart';
import '../pages/BestCourseTop3.dart';
import '../pages/GyeongNamRecommend.dart';

class MBTISelectionPage extends StatefulWidget {
  @override
  _MBTISelectionPageState createState() => _MBTISelectionPageState();
}

class _MBTISelectionPageState extends State<MBTISelectionPage> {
  Map<String, String?> selectedMBTI = {
    'EI': null,
    'SN': null,
    'TF': null,
    'JP': null,
  };

  void toggleSelection(String group, String mbti) {
    setState(() {
      selectedMBTI[group] = selectedMBTI[group] == mbti ? null : mbti;
    });
  }

  bool allGroupsSelected() {
    return selectedMBTI.values.every((element) => element != null);
  }

  void navigateToCalendarPage() {
    if (allGroupsSelected()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarSelectionPage(
            mbti: selectedMBTI.values.join(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            color: Color(0xFFE4E4E4),
            thickness: 1,
            height: 1,
          ),
          SizedBox(height: screenHeight * 0.03),
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
                    allGroupsSelected()
                        ? '${selectedMBTI.values.join()} OOO님!\n오늘은 경상남도 어디로 떠나볼까요?'
                        : '경상남도 추천지를 원하시면 \nMBTI를 선택해주세요 ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            'MBTI 맞춤형 간단 추천 코스',
            style: TextStyle(
                fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          StepOneWidget(
            selectedMBTI: selectedMBTI,
            toggleSelection: toggleSelection,
            onNextPressed: navigateToCalendarPage,
          ),
          SizedBox(height: screenHeight * 0.02),
          BestCourseTop3(),
          SizedBox(height: screenHeight * 0.02),
          GyeongNamRecommend(),
        ],
      ),
    );
  }
}

class StepOneWidget extends StatelessWidget {
  final Map<String, String?> selectedMBTI;
  final Function(String, String) toggleSelection;
  final VoidCallback onNextPressed;

  const StepOneWidget({
    required this.selectedMBTI,
    required this.toggleSelection,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(20),
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
              'STEP 01 | MBTI 입력',
              style: TextStyle(fontSize: screenHeight * 0.02),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                MBTIGroup(
                  group: 'EI',
                  verticalItems: ['E', 'I'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  group: 'SN',
                  verticalItems: ['S', 'N'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  group: 'TF',
                  verticalItems: ['T', 'F'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
                MBTIGroup(
                  group: 'JP',
                  verticalItems: ['J', 'P'],
                  selectedItems: selectedMBTI,
                  toggleSelection: toggleSelection,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: allGroupsSelected() ? onNextPressed : null,
              child: Text(
                '다음',
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: allGroupsSelected()
                    ? Colors.black.withOpacity(0.28)
                    : Color(0xFFD9D9D9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(
                    color: allGroupsSelected()
                        ? Colors.black.withOpacity(0.28)
                        : Color(0xFFD9D9D9),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool allGroupsSelected() {
    return selectedMBTI.values.every((element) => element != null);
  }
}

class MBTIGroup extends StatelessWidget {
  final String group;
  final List<String> verticalItems;
  final Map<String, String?> selectedItems;
  final Function(String, String) toggleSelection;

  const MBTIGroup({
    required this.group,
    required this.verticalItems,
    required this.selectedItems,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(screenHeight * 0.01),
      child: Column(
        children: verticalItems.map((mbti) {
          return MBTIButton(
            group: group,
            mbti: mbti,
            isSelected: selectedItems[group] == mbti,
            toggleSelection: toggleSelection,
          );
        }).toList(),
      ),
    );
  }
}

class MBTIButton extends StatelessWidget {
  final String group;
  final String mbti;
  final bool isSelected;
  final Function(String, String) toggleSelection;

  const MBTIButton({
    required this.group,
    required this.mbti,
    required this.isSelected,
    required this.toggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenHeight * 0.05,
      height: 60,
      child: ElevatedButton(
        onPressed: () => toggleSelection(group, mbti),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Text(
            mbti,
            style: TextStyle(fontSize: screenHeight * 0.05),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey[300] : Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white),
          ),
          elevation: 0,
          padding: EdgeInsets.zero,
          minimumSize: Size(screenHeight * 0.08, screenHeight * 0.08),
        ),
      ),
    );
  }
}
