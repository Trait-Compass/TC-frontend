import 'package:flutter/material.dart';

class GyeongNamRecommend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '경상남도 행사 & 축제',
                style: TextStyle(
                    fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
              ),
              SortOptions(),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          height: screenHeight * 0.25,
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
        SizedBox(height: screenHeight * 0.02),
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

class SortOptions extends StatefulWidget {
  @override
  _SortOptionsState createState() => _SortOptionsState();
}

class _SortOptionsState extends State<SortOptions> {
  String selectedOption = 'latest';

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        SortOption(
          text: '최신순',
          isSelected: selectedOption == 'latest',
          onTap: () {
            setState(() {
              selectedOption = 'latest';
            });
          },
        ),
        SizedBox(width: screenHeight * 0.02),
        SortOption(
          text: '인기순',
          isSelected: selectedOption == 'popular',
          onTap: () {
            setState(() {
              selectedOption = 'popular';
            });
          },
        ),
      ],
    );
  }
}

class SortOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SortOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenHeight * 0.02,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
