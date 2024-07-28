import 'package:flutter/material.dart';

class MBTISelection extends StatelessWidget {
  final Function(String) onSelectMBTI;
  final double boxHeight;
  final double boxWidth;
  final TextStyle textStyle;

  MBTISelection({
    required this.onSelectMBTI,
    required this.boxHeight,
    required this.boxWidth,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> mbtiList = [
      'INTJ',
      'INTP',
      'ENTJ',
      'ENTP',
      'INFJ',
      'INFP',
      'ENFJ',
      'ENFP',
      'ISTJ',
      'ISFJ',
      'ESTJ',
      'ESFJ',
      'ISTP',
      'ISFP',
      'ESTP',
      'ESFP',
    ];

    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: mbtiList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onSelectMBTI(mbtiList[index]),
            child: Container(
              height: boxHeight,
              width: boxWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFF1F2F3),
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                mbtiList[index],
                style: textStyle,
              ),
            ),
          );
        },
      ),
    );
  }
}
