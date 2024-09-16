import 'package:flutter/material.dart';
import '../mbtitest/1question.dart';

class StartTestSection extends StatelessWidget {
  final Function() onStartPressed;
  final bool isStarted;
  final Function(String) onOptionSelected;
  final String selectedOption;

  StartTestSection({
    required this.onStartPressed,
    required this.isStarted,
    required this.onOptionSelected,
    required this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth - 40,
      height: 350,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: isStarted
          ? TravelPreferencePage(
              onOptionSelected: onOptionSelected,
              selectedOption: selectedOption,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          'assets/airplane.png',
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'MBTI 테스트',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          'assets/airplane2.png',
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onStartPressed,
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
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
            ),
    );
  }
}
