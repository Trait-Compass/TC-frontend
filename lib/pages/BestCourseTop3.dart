import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BestCourseTop3 extends StatelessWidget {
  Future<List<Course>> fetchBestCourses() async {
    final response =
        await http.get(Uri.parse('https://www.traitcompass.store/course/best'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['result'];
      return jsonResponse.map((course) => Course.fromJson(course)).toList();
    } else {
      throw Exception('코스 생성중입니다! 잠시만 기다려주세요!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final PageController controller = PageController(viewportFraction: 0.95);

    return FutureBuilder<List<Course>>(
      future: fetchBestCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('코스 생성중입니다! 잠시만 기다려주세요!'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('이용 가능한 코스가 없습니다'));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20), // 화면 가장자리 여백 20px 설정
                child: Text(
                  '인기 추천코스\nBEST 3',
                  style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.25,
                child: PageView.builder(
                  controller: controller,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5), // 사진 사이의 여백 10px 설정 (양쪽에 5px씩)
                      child: RecommendedCourseCard(
                        imagePath: snapshot.data![index].imagePath,
                        title: snapshot.data![index].title,
                        location: snapshot.data![index].location,
                        mbti: snapshot.data![index].mbti,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

// 추천 코스 카드 위젯
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
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imagePath),
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

// Course 클래스 정의
class Course {
  final String imagePath;
  final String title;
  final String location;
  final String mbti;

  Course({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.mbti,
  });

  // JSON 데이터를 Course 객체로 변환하는 팩토리 생성자
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      imagePath: json['image'],
      title: json['title'],
      location: json['city'],
      mbti: json['mbti'],
    );
  }
}
