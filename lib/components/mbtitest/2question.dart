import 'package:flutter/material.dart';
import 'package:untitled/components/basicframe.dart';
import '3question.dart';

class Questions2 extends StatefulWidget {
  final Function(String) onOptionSelected;
  final String selectedOption;

  Questions2({
    required this.onOptionSelected,
    required this.selectedOption,
  });

  @override
  _Questions2State createState() => _Questions2State();
}

class _Questions2State extends State<Questions2> {
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  void handleOptionSelected(String option) {
    setState(() {
      selectedOption = selectedOption + option; // 선택된 옵션 업데이트
    });
    widget.onOptionSelected(selectedOption); // 부모에 전달
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
    final screenWidth = MediaQuery.of(context).size.width;

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
              Container(
                width: screenWidth - 40,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '여행지에서 길을 잃었을 때',
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
                                  handleOptionSelected('S');
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
                                        color: selectedOption.endsWith('S')
                                            ? Colors.grey[300]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/a.png',
                                            height: 60,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '  왔던 길로 \n 되돌아가자',
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
                                onTap: () => handleOptionSelected('N'),
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
                                        color: selectedOption.endsWith('N')
                                            ? Colors.grey[300]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/b.png',
                                            height: 60,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '일단 가보자',
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
                              builder: (context) => Questions3(
                                onOptionSelected: widget.onOptionSelected,
                                selectedOption: selectedOption,
                              ),
                            ),
                          );
                        } else {
                          _showPopupMessage(); // 문항 선택 안 했을 시 팝업 띄움
                        }
                      },
                      child: Text(
                        '다음',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    Image.asset('assets/mascoat.png', height: 100),
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
