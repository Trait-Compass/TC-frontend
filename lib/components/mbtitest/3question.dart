import 'package:flutter/material.dart';
import 'package:untitled/components/basicframe.dart';
import '4question.dart'; // Questions4 페이지를 임포트

class Questions3 extends StatefulWidget {
  final Function(String) onOptionSelected;
  final String selectedOption;

  Questions3({
    required this.onOptionSelected,
    required this.selectedOption,
  });

  @override
  _Questions3State createState() => _Questions3State();
}

class _Questions3State extends State<Questions3> {
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedOption;
  }

  void handleOptionSelected(String option) {
    setState(() {
      // 선택된 옵션을 누적해서 저장
      selectedOption = widget.selectedOption + option;
    });
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
                      '밤에 산책하다가 별을 발견했어!',
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
                                onTap: () => handleOptionSelected('T'),
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
                                        color: selectedOption.endsWith('T')
                                            ? Colors.grey[300]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/star1.png',
                                            height: 60,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '     별은 무슨 \n 인공위성이겠지',
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
                                onTap: () => handleOptionSelected('F'),
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
                                        color: selectedOption.endsWith('F')
                                            ? Colors.grey[300]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/star2.png',
                                            height: 60,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '와 너무 예뻐',
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
                          // 선택된 옵션이 있을 때만 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Questions4(
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
