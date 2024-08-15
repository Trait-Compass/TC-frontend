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
      child: SingleChildScrollView(
        child: Column(
          children: mbtiList.map((mbti) {
            return GestureDetector(
              onTap: () => onSelectMBTI(mbti),
              child: Container(
                height: boxHeight,
                width: boxHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F2F3),
                  border: Border.all(
                    color: Color(0xFFF1F2F3),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  mbti,
                  style: textStyle,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
