import 'package:flutter/material.dart';

class BestCourseTop3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Text(
            '인기 추천코스\nBEST 3',
            style: TextStyle(
                fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          height: screenHeight * 0.25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              RecommendedCourseCard(
                imagePath: 'assets/course1.png',
                title: '해금강해안도로',
                location: '거제',
                mbti: 'ENTP',
              ),
              RecommendedCourseCard(
                imagePath: 'assets/course2.png',
                title: '시간여행마을',
                location: '창녕',
                mbti: 'ISTJ',
              ),
              RecommendedCourseCard(
                imagePath: 'assets/course3.png',
                title: '우포늪',
                location: '창녕',
                mbti: 'ESTJ',
              ),
              Container(
                width: screenWidth * 0.3,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/your_image.png', // 여기에 이미지 경로를 넣으세요
                        height: screenHeight * 0.04, // 적절한 높이로 조절하세요
                      ),
                      SizedBox(
                          width: screenWidth * 0.02), // 이미지와 텍스트 사이의 간격을 조절하세요
                      Text(
                        '다른 코스가 보고 싶다면?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenHeight * 0.015),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecommendedCourseCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String mbti;

  const RecommendedCourseCard({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.mbti,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.4,
      margin:
          EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: screenHeight * 0.01,
            left: screenWidth * 0.025,
            child: Text(
              '$mbti\n$title\n$location',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
