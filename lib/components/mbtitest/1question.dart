import 'package:flutter/material.dart';
import '../mbtitest/2question.dart';

class TravelPreferencePage extends StatefulWidget {
  final Function(String) onOptionSelected;
  final String selectedOption;

  TravelPreferencePage({
    required this.onOptionSelected,
    required this.selectedOption,
  });

  @override
  _TravelPreferencePageState createState() => _TravelPreferencePageState();
}

class _TravelPreferencePageState extends State<TravelPreferencePage> {
  String selectedOption = ''; // 사용자가 선택한 옵션을 저장하는 변수
 
 
  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  void _selectOption(String option) {
    setState(() {
      selectedOption = option;
    });
    widget.onOptionSelected(selectedOption); // 부모에 선택된 값 전달
  }

  void _showPopupMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '문항을 선택해주세요',
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '여행을 가고 싶은 곳은?',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _selectOption('I');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: selectedOption == 'I'
                                ? Colors.grey[300]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/nature.png',
                                height: 60,
                              ),
                              SizedBox(height: 10),
                              Text(
                                '한적한 자연',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _selectOption('E');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: selectedOption == 'E'
                                ? Colors.grey[300]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/city.png',
                                height: 60,
                              ),
                              SizedBox(height: 10),
                              Text(
                                '신나는 도시',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              child: Image.asset(
                'assets/vs.png',
                height: 100,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (selectedOption.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Questions2(
                    onOptionSelected: widget.onOptionSelected,
                    selectedOption: selectedOption,
                  ),
                ),
              );
            } else {
              _showPopupMessage(); // 문항을 선택하지 않으면 팝업 띄움
            }
          },
          child: Text(
            '다음',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
