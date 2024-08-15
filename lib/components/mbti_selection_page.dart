import 'package:flutter/material.dart';
import '../pages/calendar_selection_page.dart'; // 달력 선택 페이지 파일을 import

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(
          color: Color(0xFFE4E4E4), // 실선 색상 설정
          thickness: 1,
          height: 1,
        ),
        SizedBox(height: screenHeight * 0.03),
        Row(
          children: [
            SizedBox(width: screenWidth * 0.05),
            Image.asset('assets/animation.png',
                height: screenHeight * 0.07), // 사람 아이콘 경로
            SizedBox(width: screenWidth * 0.02),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.015,
                    horizontal: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  allGroupsSelected()
                      ? '${selectedMBTI.values.join()} OOO님!\n오늘은 경상남도 어디로 떠나볼까요?'
                      : '경상남도 추천지를 원하시면 MBTI를 선택해주세요 !!',
                  style: TextStyle(fontSize: screenHeight * 0.02),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
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
      ],
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
      padding: EdgeInsets.all(screenHeight * 0.03),
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
            SizedBox(
                height: screenHeight * 0.03), // 여기는 step1텍스트와 MBTI박스 간격 조절 부분
            Wrap(
              alignment: WrapAlignment.center,
              spacing: screenHeight * 0.03, // mbti박스 간격 조절 부분
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
            SizedBox(height: screenHeight * 0.03), // 요놈은 '다음'박스랑 MBTI박스사이 거리
            ElevatedButton(
              onPressed: allGroupsSelected() ? onNextPressed : null,
              child: Text('다음'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white, // 비활성화 색상 설정
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02), // 이건 '다음'이랑 박스내부 비율
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
      padding: EdgeInsets.all(screenHeight * 0.01), // 이건 뭔가 박스랑 글자사이 간격비율같은데...
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
      width: screenHeight * 0.08, // 이건 세로박스 너비
      height: screenHeight * 0.08, // 이건 세로박스 높이
      margin: EdgeInsets.all(screenHeight * 0.004),
      child: ElevatedButton(
        onPressed: () => toggleSelection(group, mbti),
        child: Padding(
          padding: EdgeInsets.all(0), // 글자와 박스 사이의 간격을 조절합니다. 필요시 값을 조정하세요.
          child: Text(
            mbti,
            style: TextStyle(fontSize: screenHeight * 0.05), // 이건 MBTI 글자크기
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.grey[300] : Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white), // 경계선을 흰색으로 설정
          ),
          elevation: 0, // 음영 제거
          padding: EdgeInsets.zero, // 버튼 내부 여백을 0으로 설정
          minimumSize:
              Size(screenHeight * 0.08, screenHeight * 0.08), // 버튼 크기를 고정
        ),
      ),
    );
  }
}
