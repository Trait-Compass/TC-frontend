import 'package:flutter/material.dart';

class GyeongNamRecommend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '경상남도 행사 & 축제',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              EventFestivalCard(
                imagePath: 'assets/event1.png',
                title: '거제 바다로 세계로',
                description: '거제의 대표적인 여름 축제',
              ),
              EventFestivalCard(
                imagePath: 'assets/event2.png',
                title: '창녕 남지 유채꽃 축제',
                description: '봄에 즐기는 아름다운 유채꽃',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EventFestivalCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const EventFestivalCard({
    required this.imagePath,
    required this.title,
    required this.description,
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
              '$title\n$description',
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
