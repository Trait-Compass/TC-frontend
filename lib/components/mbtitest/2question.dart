import 'package:flutter/material.dart';

class Questions2 extends StatelessWidget {
  final Function(String) onOptionSelected;
  final String selectedOption;

  Questions2({
    required this.onOptionSelected,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    onTap: () => onOptionSelected('nature'),
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
                            color: selectedOption == 'nature'
                                ? Colors.grey[300]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                '../assets/a.png',
                                height: 60,
                              ),
                              SizedBox(height: 10),
                              Text(
                                '왔던 길로 되돌아가자',
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
                    onTap: () => onOptionSelected('city'),
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
                            color: selectedOption == 'city'
                                ? Colors.grey[300]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                '../assets/b.png',
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
                '../assets/vs.png',
                height: 100,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // 다음 버튼을 눌렀을 때의 로직 추가
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
